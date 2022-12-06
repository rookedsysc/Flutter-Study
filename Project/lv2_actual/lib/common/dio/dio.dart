import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lv2_actual/common/const/data.dart';


class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  CustomInterceptor({
    required this.storage,
  });

  // 요청을 보낼 때
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // method: Post / Get, option: url, data, headers
    debugPrint('[REQUEST] ${options.method} ${options.uri}');

    // 요청이 보내질 때마다 요청의 Header에 accessToken: true가 있으면 
    // 실제 토큰을 가져와서 authorization: bearer $token 형태로 헤더를 변경한다. 
    // 매번 토큰을 코드상에 정의해놓을 수 없기 때문에 해당하는 과정을 사용한다.
    if(options.headers['accessToken'] == 'true') {
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
  
  // 2) 응답을 받을 때
  // 3) 에러가 발생했을 때

}