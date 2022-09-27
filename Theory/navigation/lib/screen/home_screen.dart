import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 안드로이드에서 최상단에 기본적으로 뒤로가기를 할 수 있는 버튼이 있음.
      onWillPop: () async {
        // 여기에 false를 return 해주게 되면 최상단에서 뒤로가기 Button으로 앱을 빠져나갈 수 없게 됨.
        return false;
      },
      child: MainLayout(title: 'HomeScreen', children: [
        ElevatedButton(
            onPressed: () {
              // 더 이상 뒤로 갈 stack이 없을 때 뒤로 가기 버튼이 동작하지 않음.
              Navigator.of(context).maybePop();
            },
            child: Text('Pop')),
        ElevatedButton(
            onPressed: () async {
              // result에는 push된 스크린에서 pop 할 때 인자로 보내주는 값이 들어가게 됨.
              // 이 때 push를 해주고 pop에서 값을 받을 때까지 기다려야 하기 때문에 await을 사용해줘야 함.
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext cotnext) => RouteMainScreen(
                    number: 55555,
                  ),
                ), // push로 값을 보내는 경우는 costructor로 보냄.
              );
            },
            child: Text('Push'))
      ]),
    );
  }
}
