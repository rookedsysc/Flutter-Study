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
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text('Push Replacement',
        textAlign: TextAlign.center,),
      ),
      ElevatedButton(
          onPressed: () {
            // 현재 Route를 대체해서 Push를 함. 즉, 현재 Route Pop > builder Screen Push 이런식으로 동작 됨.
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
          },
          child: Text('Push Replacement')),
      // pushReplacementNamed
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: Text('Push Replacement')),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text('Push And Remove Until'
        ,textAlign: TextAlign.center,),
      ),
      ElevatedButton(
          onPressed: () {
            // 현재까지 넣어줬떤 모든 Route들을 다 삭제해줌.
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => RouteThreeScreen()),
                // False가 전달이 되면 Stack에 있는 모든 Route들이 다 삭제됨.
                // true 값을 넘겨주면 모든 Route들이 살아있게 됨.
                // 아래와 같이 route.settings.name에 해당하는 route key값을 넘겨주게 되면 해당 route만 true가 됨.
                // 즉, 해당 route를 제외한 모든 route들은 Stack에서 지워짐.
                (route) => route.settings.name == '/');
          },
          child: Text('Push And Remove Until')),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/three',(route) => route.settings.name == '/');
          },
          child: Text('Push Named And Remove Until')),
    ]);
  }
}
