import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteMainScreen extends StatelessWidget {
  final int? number;

  const RouteMainScreen({this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Main Route Screen',
      children: [
        Text(
          'arguments: ${number.toString()}',
          // Text Field안에서 가운데로 정렬됨.
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
            onPressed: () {
              print(Navigator.of(context)
                  .canPop()); // 아무런 pop 동작도 하지 않고 return만 주는 역할.
            },
            child: Text('Can Pop')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop')),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(3030303);
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => RouteTwoScreen(),
                  // push의 Setting을 통해서 다른 스크린에 값을 전달 해줄 수 있음.
                  settings: RouteSettings(arguments: 789)),
            );
          },
          child: Text('Push'),
        ),
      ],
    );
  }
}
