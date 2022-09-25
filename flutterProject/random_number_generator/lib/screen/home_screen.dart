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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween

              , children: [
            Text('랜덤 숫자 생성기'),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings
              ),
            ),
          ]),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('123'),
              Text('456'),
              Text('789'),
            ],
          )),
          SizedBox( // SizedBox는 너비와 높이만 정할 수 있음. 간단한 대신 정~~~말 조금 더 빠름.
            width: double.infinity, // 무한대 값을 넣어줘도 삐져나가지 않음
            child: ElevatedButton(onPressed: (){}, child: Text('생성하기!'),
            ),
          )

        ]),
      ),
    );
  }
}
