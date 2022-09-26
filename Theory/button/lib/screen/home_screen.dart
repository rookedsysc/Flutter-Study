import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ElevatedButton은 ElevatedButton.styleFfrom 안에서 스타일 지정가능함.
            ElevatedButton(onPressed: (){}, child: Text('ElevatedButton'), style: ElevatedButton.styleFrom(
              primary: Colors.red, // 메인 컬러.
              onPrimary: Colors.black, // 글자 색상, button 눌렀을 때 애니메이션 효과.
              shadowColor: Colors.green, // 그림자 색상.
              elevation: 10.0, // z축으로 더 튀어나오게 만들 수 있음. (3D 입체감의 높이)
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
              // Text Style의 padding
              padding: EdgeInsets.all(32.0),
              side: BorderSide(
                color: Colors.black,
                width: 4.0,
              ), // 테두리

            ),), // 약간 3D 형로 돌출되어 있고 배경 있음.
            OutlinedButton(onPressed: (){}, child: Text('OutlinedButton')), // 배경 없이 outline만 있음.
            TextButton(onPressed: (){}, child: Text('TextButton')) // 아무것도 없고 Text만 있음.
          ],
        ),
      ),
    );
  }
}
