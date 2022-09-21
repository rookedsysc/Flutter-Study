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
