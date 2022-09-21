import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // 오른쪽 위에 표시되는 banner 표시 삭제
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
      backgroundColor: Color(0xFFF99231), // 맨 앞의 FF는 투명도를 의미.
      // chilren을 통해서 여러 개의 위젯을 넣을 수 있게 해줌.
      body: Column( // 가장 위에 chidlren 값을 배치함, Column의 주축은 세로임.
        mainAxisAlignment: MainAxisAlignment.center, // children을 중앙에 배치함.(세로기준)
        children: [
          Image.asset("asset/img/logo.png"),

          // 로딩바
          CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
