import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false, // iOS에서 만 적용됨.
        // Container 안에 widget들을 넣을 수 있음.
        child: Container(
          color: Colors.black,
          child: Column(
            /* MainAxisAlignment - 주축 정렬.
            start - 시작에 정렬.
            end - 끝에 정렬.
            center - 가운데 정렬.
            spaceBetween - 시작과 끝에 배치되고 위젯과 위젯의 사이가 동일하기 배치됨.
            spaceEvenly - 위젯을 같은 간격으로 배치하지만 끝과 끝에도 위젯이 아닌 빈 간격으로 시작함.
            spaceArround - spaceEvenly에서 끝과 끝의 간격을 반만 줌.
             */
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.red,
                width: 50.0,
                height: 50.0,
              ),
              Container(
                color: Colors.green,
                width: 50.0,
                height: 50.0,
              ),
              Container(
                color: Colors.yellow,
                width: 50.0,
                height: 50.0,
              ),
              Container(
                color: Colors.blue,
                width: 50.0,
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
