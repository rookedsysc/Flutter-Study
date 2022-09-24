import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('Timer!');
    });
  }

  // State의 생명주기의 마지막, 생명주기가 끝날 때 실행됨
  @override
  void dispose() {
    super.dispose();

    if (timer != null) {
      // timer가 null이 아닌데 오류 발생함.
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Image.asset(
                'asset/img/image_$e.jpeg',
                // 전체화면, 위아래나 좌우 중 짤려서 나올 수 있음.
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
