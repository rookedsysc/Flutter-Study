import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime; // true - 시간 false - 내용
  final FormFieldSetter<String> onTextSaved;
  const  CustomTextField({required this.onTextSaved, required this.isTime, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,style: TextStyle(
          fontWeight: FontWeight.w500,
          color: PRIMARY_COLOR,
        ),),
        if(isTime) renderTextField(),
        if(!isTime) Expanded(child: renderTextField())
      ],
    );
  }
  Widget renderTextField() {
    return TextFormField(
      // null이 return 되면 에러가 없다는 뜻임.
      // 에러가 있으면 에러를 String 값으로 return 해줌.
      validator: (String? val) {
        if(val == null || val.isEmpty) {
          return '값을 입력해주세요.';
        }
        return null;
      },
      onSaved: onTextSaved,

      // 밑줄 색상
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.black),
      // 부모 class의 남은 부분만큼 textField가 커짐.
      expands: !isTime,
      maxLines: isTime ? 1 : null, // 줄바뀜 옵션. (null이면 무한하게 라인 작성가능)
      decoration: InputDecoration(
        border: InputBorder.none, // text field 밑에 밑줄 사라짐.
        filled: true, // 색상 채울 수 있게 해줌.
        fillColor: Colors.grey[300],
      ),

      // Text Field 숫자만 입력되게 하는 설정.
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly // 숫자를 필터링해서 아예 입력이 안되게 해줌.
      ] : [],
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline, // 키보드 형식을 숫자로 변경해줌.
    );
  }
}

