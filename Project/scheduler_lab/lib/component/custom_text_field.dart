import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  const  CustomTextField({required this.label, Key? key}) : super(key: key);

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
            decoration: InputDecoration(
              border: InputBorder.none, // text field 밑에 밑줄 사라짐.
              filled: true, // 색상 채울 수 있게 해줌.
              fillColor: Colors.grey[300],
            ),
        ),
      ],
    );
  }
}
