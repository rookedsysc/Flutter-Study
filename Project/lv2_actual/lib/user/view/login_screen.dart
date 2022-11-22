import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lv2_actual/common/component/custom_text_form_field.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: SafeArea(
      top: true,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Title(),
            const _SubTitle(),
            Image.asset('asset/img/misc/logo.png', height: 200.0,width: MediaQuery.of(context).size.width / 3 * 2,),
            CustomTextFormField(
              hintText: '이메일을 입력해주세요.',
              onChanged: (String value) {},
            ),
            CustomTextFormField(
              hintText: '비밀번호를 입력해주세요.',
              onChanged: (String value) {},
              obscureText: true,
            ),
            ElevatedButton(onPressed: (){}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: const Text('로그인')),
            TextButton(onPressed: (){}, 
            style: TextButton.styleFrom(
              foregroundColor: PRIMARY_COLOR,
            ),
            child: const Text('회원가입')),
          ],
        ),
    ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('환영합니다.', style: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w500,
      color: Colors.black
    ));
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)', 
    style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
