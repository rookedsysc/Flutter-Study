import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/provider/secure_storage.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/common/view/root_tab.dart';
import 'package:lv2_actual/user/view/login_screen.dart';

// 앱을 처음 진입하면 잠깐동안 보여지는 스플래시 화면
// 어떤 페이지로 보내줘야 할지 판단을 하는 기본적인 화면이 됨
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // deleteToken(); // 토큰 삭제 테스트
    // checkToken이 실행이 되는 동안은 Splash Screen이 보여지게 됨
    checkToken();
  }

  void deleteToken() async {
    final storage = ref.read(secureStorageProvider);
    // 토큰을 삭제하는 로직
    await storage.deleteAll();
  }

  void checkToken() async {
    // flutter secure storage에서 Token을 가져옴
    final storage = ref.read(secureStorageProvider);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      // access Token 재발급 ( refresh Token이 유효한지 검증 )
      final resp = await dio.post(
        "http://$ip/auth/token",
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      // 발급 받은 토큰 저장
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      // 200이 아닌 경우 로그인 화면으로 이동
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RootTab(),
          ),
          (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
