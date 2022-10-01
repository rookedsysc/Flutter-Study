import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({Key? key}) : super(key: key);

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  final textStyle = TextStyle(fontSize: 16.0,);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>( // Stream과 Future Builder 모두 generic을 넣을 수 있음.
          stream: streamNumber(), // snapshot과 관련된 어떠한 값이 바뀌더라도 builder가 재실행됨.
          builder: (context, snapshot) {

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'StreamBuilder',
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                Text(
                  // Future builder와 비교해서 Connection.active 상태가 추가
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
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        // setState에서 함수를 재실행해도 이전 실행의 data를 담고 있음.
                        getNumber();
                      });
                    },
                    child: Text('setState')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    child: Text('Pop to HomeScreen'))
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

    // 원하는 error 출력
    throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }

  Stream <int> streamNumber() async* {
    for(int i = 0; i < 10; i ++) {
      await Future.delayed(Duration(seconds: 1));
      if (i == 5) {
        throw Exception('에러가 발생했습니다.');
      }

      yield i;
    }
  }
}
