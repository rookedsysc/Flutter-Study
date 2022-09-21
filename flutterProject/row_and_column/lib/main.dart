import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home:HomeScreen(),
    ),
  );
}

// stless를 입력하면 자동으로 StatlessWidget class 작성
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
