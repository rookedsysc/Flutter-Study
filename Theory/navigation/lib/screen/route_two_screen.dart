import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

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
    ]);
  }
}
