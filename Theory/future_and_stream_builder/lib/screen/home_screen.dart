import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textStyle = TextStyle(fontSize: 16.0,);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getNumber(), // snapshot과 관련된 어떠한 값이 바뀌더라도 builder가 재실행됨.
          builder: (context, snapshot) {
            if(!snapshot.hasData){ // 프로그램 최초 실행시에 캐싱 된 데이터도 없을 때 최초 실행됨.
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'FutureBuilder',
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                Text(
                  'conState: ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Stack(
                  children: [
                    Text('Data: ${snapshot.data}'),
                    // 데이터를 받아오는 상태일 때 이런 식으로 인디케이터 표시 가능.
                    if(snapshot.connectionState == ConnectionState.waiting)
                      SizedBox(
                        child: CircularProgressIndicator(),
                        height: 20.0,
                        width: 20.0,
                      ),
                  ],
                ),
                Text('Error : ${snapshot.error}'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // setState에서 함수를 재실행해도 이전 실행의 data를 담고 있음.
                        getNumber();
                      });
                    }, child: Text('setState'))
              ],
            );
          },
        ),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));
    final random = Random();

    return random.nextInt(100);
  }
}
