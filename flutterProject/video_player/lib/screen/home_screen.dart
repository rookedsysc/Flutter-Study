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
      body: Container(
        width: MediaQuery.of(context).size.width,
        // decoration과 color를 같이 사용하면 error 발생함.
        decoration: getBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Logo(),
            SizedBox(
              height: 30,
            ), // Padding 대신 사용.
            _AppName(),
          ],
        ),
      ),
    );
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      // RadialGradient는 가운데서부터 동그랗게 퍼지는 색상.
      gradient: LinearGradient(
        begin: Alignment.topCenter, // 어디서부터 시작하는지
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7c), // 위에서부터 시작되는 색상
          Color(0xFF0001118) // 아래의 마지막 색상
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/image/logo.png',
      alignment: Alignment.center,
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "VIDEO",
          style: textStyle,
        ),
        Text(
          'PLAYER',
          // copyWith 덮어씌우기
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
