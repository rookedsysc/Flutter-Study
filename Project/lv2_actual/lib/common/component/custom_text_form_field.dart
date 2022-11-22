import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/colors.dart';


class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  const CustomTextFormField(
      {this.obscureText = false,
      this.autofocus = false,
      this.errorText,
      this.hintText,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {

    // 모든 Input 상태의 기본 스타일 세팅
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 1.0,
        color: INPUT_BORDER_COLOR),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 비밀번호 입력할 때 ****로 표시
      obscureText: obscureText,
      // 자동으로 다음 텍스트필드로 이동
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText, 
        errorText: errorText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        // false - 배경색 없음 / true - 배경색 있음
        fillColor: INPUT_BG_COLOR,
        filled: true,
        // 모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR)),



        
      ),
    );
  }
}