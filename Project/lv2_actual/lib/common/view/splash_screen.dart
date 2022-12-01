import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/common/view/root_tab.dart';
import 'package:lv2_actual/user/view/login_screen.dart';


// 앱을 처음 진입하면 잠깐동안 보여지는 스플래시 화면
// 어떤 페이지로 보내줘야 할지 판단을 하는 기본적인 화면이 됨
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // deleteToken(); // 토큰 삭제 테스트
    // checkToken이 실행이 되는 동안은 Splash Screen이 보여지게 됨
    checkToken();
  }

  void deleteToken() async {
    // 토큰을 삭제하는 로직
    await storage.deleteAll();
  }

  void checkToken() async {
    // flutter secure storage에서 Token을 가져옴
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // Token이 존재한다면 로그인 페이지로 들어가게 됨
    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
          (route) => false);
    } else { /* Token이 존재하지 않는다면 Root Tab으로 들어가게 됨 */
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RootTab(),
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
          Image.asset('asset/img/logo/logo.png'
              , width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(height: 16),
          const CircularProgressIndicator( color: Colors.white,),
      ],
    ),
        ));
  }
}
