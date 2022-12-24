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
class SplashScreen extends ConsumerWidget {
  static String get routeName => '/splash';
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
