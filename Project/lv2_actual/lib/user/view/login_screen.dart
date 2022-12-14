import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lv2_actual/common/component/custom_text_form_field.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/riverpod/secure_storage.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/common/view/root_tab.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    final dio = Dio();

    return DefaultLayout(child: SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          // 스크롤 했을 때 키보드 내려감
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Title(),
                  const _SubTitle(),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    height: MediaQuery.of(context).size.height * 0.46,
                    width: MediaQuery.of(context).size.width / 3 * 2,
                  ),
                  CustomTextFormField(
                    hintText: '이메일을 입력해주세요.',
                    onChanged: (String value) {
                      username = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요.',
                    onChanged: (String value) {
                      password = value;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),

                  // 로그인 버튼
                  ElevatedButton(
                      onPressed: () async {
                        String rawString = '$username:$password';
                        debugPrint('[!] press login button\n id \/ pw : $rawString');

                        // 어떻게 인코딩 할건지 정의
                        Codec<String, String> stringToBase64 = utf8.fuse(base64);
                        // 정의를 이용해서 rawString을 인코딩
                        String token = stringToBase64.encode(rawString);

                        final resp = await dio.post(
                          'http://$ip/auth/login',
                          options: Options(
                            headers: {
                              'authorization': 'Basic $token',
                            },
                          ),
                        );

                        final refreshToken = resp.data['refreshToken'];
                        final accessToken = resp.data['accessToken'];

                        final storage = ref.read(secureStorageProvider);


                        // flutter secure storage에 Token 저장
                        await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RootTab(),
                          ),
                        );
                        debugPrint(resp.data.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text('로그인')),

                  // 회원가입 버튼
                  TextButton(onPressed: () {
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('회원가입')),
                ],
              ),
          ),
        ),
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
