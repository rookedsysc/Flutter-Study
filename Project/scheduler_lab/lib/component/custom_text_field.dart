import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  const  CustomTextField({required this.isTime, required this.label, Key? key}) : super(key: key);
  final bool isTime; // true - 시간 false - 내용

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,style: TextStyle(
          fontWeight: FontWeight.w500,
          color: PRIMARY_COLOR,
        ),),
        TextField(
            cursorColor: Colors.grey,
            expands: isTime,
            maxLines: isTime ? 1 : null, // 줄바뀜 옵션. (null이면 무한하게 라인 작성가능)
            decoration: InputDecoration(
              border: InputBorder.none, // text field 밑에 밑줄 사라짐.
              filled: true, // 색상 채울 수 있게 해줌.
              fillColor: Colors.grey[300],
            ),
          inputFormatters: isTime ? [
            FilteringTextInputFormatter.digitsOnly // 숫자를 필터링해서 아예 입력이 안되게 해줌.
          ] : [],
          keyboardType: isTime ? TextInputType.number : TextInputType.multiline, // 키보드 형식을 숫자로 변경해줌.
        ),
      ],
    );
  }
}
