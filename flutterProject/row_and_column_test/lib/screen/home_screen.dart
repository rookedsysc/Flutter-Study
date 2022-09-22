import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            // 첫 번째 행
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.orange,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),

              // 두 번째 행
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.orange,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),

              // 세 번째 행
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.orange,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),

              // 네 번째 행
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
