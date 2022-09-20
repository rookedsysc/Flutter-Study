import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  // StatelessWidget을 상속받으면 반드시 override 해줘야 하는 함수.
  @override
  Widget build(BuildContext context) {
    // Hot Reload는 build 함수에 있는 코드만 재실행을 함.
    return Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
