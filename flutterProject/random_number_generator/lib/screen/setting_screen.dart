import 'package:flutter/material.dart';
import 'package:random_number_generator/contant/color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _NumberArea(maxNumber: maxNumber.toInt()),
              _Footer(onSaveButtonPressed: onSaveButtonPressed, maxNumber: maxNumber, onChanged: onSlidderChanged)
            ],
          ),
        ),
      ),
    );
  }

  void onSaveButtonPressed() { // setState도 없는데 굳이 왜 정리해주는지 모르겠음.
    // 저장 버튼을 누르면 홈으로 돌아감.
    Navigator.of(context)
        .pop(maxNumber.toInt() // 홈스크린의 push한 위치로 데이터 넘겨줌.
    );
  }

  void onSlidderChanged(double val) {
    setState(() {
      // val의 값이 바뀔 때마다 maxNumber를 변경해줌.
      // 이렇게 해주지 않으면 rebuild 과정을 거치지 않아서 Slider의 버튼이 움직이지 않음.
      maxNumber = val;
    });
  }// ValueChange<double> 함수
}

class _NumberArea extends StatelessWidget {
  final int maxNumber;

  const _NumberArea({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: maxNumber
            .toString()
            .split('')
            .map(
              (e) => Image.asset(
                'asset/img/$e.png',
                width: 50.0,
                height: 70.0,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final ValueChanged<double> onChanged;
  final double maxNumber;
  final VoidCallback onSaveButtonPressed;
  const _Footer({required this.maxNumber, required this.onSaveButtonPressed,
  required this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // Slider와 저장 버튼을 Colum에 다시 묶어줬기 때문에 Column만 Strech되어 있음.
      // Column 내부에서 한 번 더 Stretch를 해줘야 Button이 늘어나게 됨.
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onChanged
        ),
        ElevatedButton(
            onPressed: onSaveButtonPressed,
            style: ElevatedButton.styleFrom(primary: redColor),
            child: Text(
              '저장!',
            ))
      ],
    );

  }
}
