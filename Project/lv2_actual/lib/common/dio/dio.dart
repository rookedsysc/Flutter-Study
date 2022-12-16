import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/provider/secure_storage.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();
  dio.interceptors.add(CustomInterceptor(storage: ref.watch(secureStorageProvider)));
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  CustomInterceptor({
    required this.storage,
  });

  // 요청을 보낼 때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // method: Post / Get, option: url, data, headers
    debugPrint('[REQUEST] ${options.method} ${options.uri}');

    // 요청이 보내질 때마다 요청의 Header에 accessToken: true가 있으면
    // 실제 토큰을 가져와서 authorization: bearer $token 형태로 헤더를 변경한다.
    // 매번 토큰을 코드상에 정의해놓을 수 없기 때문에 해당하는 과정을 사용한다.
    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');
      // 실제 토큰으로 대체
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // header에 accessToken 값을 추가
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 응답을 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('[RESPONSE] ${response.requestOptions.method} ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  // 에러가 발생했을 때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을 때 (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면 다시 새로운 토큰으로 요청한다.
    debugPrint(
        '[ERROR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 없으면 에러를 return
    if (refreshToken == null) {
      // handler에는 onRequest가 실제 request를 보내기 전 요청을 보낼지 아니면 에러를 생성시킬지 결정을 하고 있음
      // 에러 return 함
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    // refresh 요청을 하려다가 에러가 났음. 즉, refreshToken 자체가 문제가 있음.
    final isPathRefresh = err.requestOptions.path == '/auth/refresh';

    // 401에러가 났고 Refresh 요청이 아니라면 해당 구문 실행
    // Refresh 요청인지 검증 하는 이유는 
    // Refresh 요청을 하다가 401에러가 났다면 해당 Refresh Token이 유효하지 않다는 의미이기 때문
    if (isStatus401 && !isPathRefresh) {
      try {
        final dio = Dio();

        // 새로운 accessToken을 받아옴
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );
        final accessToken = resp.data['accessToken'];

        // 새로운 accessToken을 받는데 성공하면 
        // token을 request header에 추가하고 storage에도 저장함
        final options = err.requestOptions;
        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken); 

        // 에러를 발생시킨 옵션에서 accessToken만 변경 후 요청 재전송
        final response = await dio.fetch(options);

        // handler.resolve(response)는 에러가 나든 어쩌든 그 결과값을 Response로 받아서 다음으로 넘겨줌
        // 즉, accessToken을 재발급 받아서 다시 요청을 보내고 그 성공한 결과값을 받아서 dio 생성지점으로 넘겨줌
        return handler.resolve(response);
      } on DioError catch (e) {
        // refresh 요청을 하려다가 에러가 났음. 즉, refreshToken 자체가 문제가 있음.
        // 그래서 refreshToken을 지워줌
        await storage.delete(key: REFRESH_TOKEN_KEY);
        // 에러를 return
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
