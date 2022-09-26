import 'package:flutter/material.dart';

// setting_screen과 home_screen에서 동시에 사용되는 코드를 여기서 선언해서 사용함.
class NumberToImageFileName extends StatelessWidget {
  final int number;
  const NumberToImageFileName({required this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number
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
    );
  }
}
