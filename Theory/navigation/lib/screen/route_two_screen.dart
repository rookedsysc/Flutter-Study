import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Modal Route는 풀 스크린의 위젯을 말함. 여기서 말하는 가장 가까운 풀 스크린의 위젯은 main_route 위젯이 됨.
    final arguments =
        ModalRoute.of(context)!.settings.arguments; // build 안에서 받아줘야 함.

    return MainLayout(title: 'Route Two Screen', children: [
      Text(
        'arguments: ${arguments}',
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Pop'),
      ),
      ElevatedButton(
        onPressed: () {
          // routes의 key값을 전달해주면 됨.
          // pushNamed는 기본적으로 인자값을 arguments를 지원해줌. 여기에 전달할 값을 전달하면 됨.
          Navigator.of(context).pushNamed('/three', arguments: 2002002);
        },
        child: Text('Push Named'),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
          },
          child: Text('Push Replacement'))
    ]);
  }
}
