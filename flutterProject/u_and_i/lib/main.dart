import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower', // 기본 폰트 설정
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 80,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.w700, // 텍스트 굵기
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    home: HomeScreen(),
  ));
}
