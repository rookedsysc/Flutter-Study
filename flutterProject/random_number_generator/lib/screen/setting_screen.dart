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
              Expanded(
                child: Row(
                    children: maxNumber
                        .toString()
                        .split('')
                        .map(
                          (e) => Image.asset(
                            'asset/img/$e.png',
                            width: 50.0, height: 70.0,
                          ),
                        )
                        .toList(),
                ),
              ),
              Slider(value: maxNumber, min: 1000, max: 100000, onChanged: (double val) {
                setState(() {
                  // val의 값이 바뀔 때마다 maxNumber를 변경해줌.
                  // 이렇게 해주지 않으면 rebuild 과정을 거치지 않아서 Slider의 버튼이 움직이지 않음.
                  maxNumber = val;
                });

                },// ValueChange<double> 함수
              ),
              ElevatedButton(onPressed: (){// 저장 버튼을 누르면 홈으로 돌아감.
                Navigator.of(context).pop(
                  maxNumber.toInt() // 홈스크린의 push한 위치로 데이터 넘겨줌.
                );

              },
                  style: ElevatedButton.styleFrom(
                    primary: redColor
                  ),
                  child: Text('저장!',))
            ],
          ),
        ),
      ),
    );
  }
}
