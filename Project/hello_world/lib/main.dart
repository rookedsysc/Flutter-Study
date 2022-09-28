import 'package:flutter/material.dart';

void main() {
  runApp(
    // Materail App은 반드시 들어가야 함. 국룰임.
    MaterialApp(
      home: Scaffold(
        // background color
        backgroundColor: Colors.black,
        // 글자 중앙에 배치
        body: Center(
          // 글자 색상, 크기
          child: Text(
            'Hello World',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    ),
  );
}

