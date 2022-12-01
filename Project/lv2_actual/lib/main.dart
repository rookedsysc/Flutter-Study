import 'package:flutter/material.dart';
import 'package:lv2_actual/common/component/custom_text_form_field.dart';
import 'package:lv2_actual/common/view/splash_screen.dart';
import 'package:lv2_actual/user/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Notosans',
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen()
    );
  }
}
