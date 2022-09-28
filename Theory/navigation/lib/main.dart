import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_main_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

void main() {
  runApp(MaterialApp(
    // home: HomeScreen(),
    initialRoute: '/', // 초기 실행시 표시되는 라우트
    // routes를 추가했다고 해서 Material Page Route 방식을 사용할 수 없게 된 것은 아님
    routes: {  // Map - Key: Value(builder)
      '/': (context) => HomeScreen(), // home 무조건 '/'
      '/one' : (context) => RouteMainScreen( ),
      '/two' : (context) => RouteTwoScreen(),
      '/three' : (context) => RouteThreeScreen(),
    },
  ));
}
