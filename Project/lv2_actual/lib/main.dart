import 'package:flutter/material.dart';
import 'package:lv2_actual/common/component/custom_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: '이메일을 입력해주세요.', onChanged: (String value) {  }, 
            ),
            CustomTextFormField(
              hintText: '비밀번호를 입력해주세요.', onChanged: (String value) {  }, obscureText: true,
            )
          ],
        ),
      ),
    );
  }
}
