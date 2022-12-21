import 'package:flutter/material.dart';
import 'package:go_route_example/screen/1_screen.dart';
import 'package:go_route_example/screen/2_screen.dart';
import 'package:go_route_example/screen/3_screen.dart';
import 'package:go_route_example/screen/err_screen.dart';
import 'package:go_route_example/screen/home_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  _App({super.key});

  final _router = GoRouter(
    // 홈스크린
    initialLocation: '/',
    // 네이게이션 과정 중에서 에러가 발생했을 때 
    // state에 에러 메시지가 들어가고 
    // ErrScreen으로 이동

    errorBuilder: (_, state) => ErrScreen(err: state.error.toString()),
        routes: [
          GoRoute(
            path: '/',
            // state에는 파라미터가 들어있음
            builder: (_, state) => HomeScreen(),
              routes: [
                GoRoute(
                    // nesting : 라우트 안에 라우트 넣을 때는 '/'를 빼도 됨
                  path: 'one',
                  builder: (_, state) => OneScreen(),
                  // http://..../one/two와 같은 형식으로 nesting됨
                  routes: [
                    GoRoute(
                        path: 'two',
                        builder: (_, state) => TwoScreen(),
                        routes: [
                          GoRoute(
                            path: 'three',
                            name: ThreeScreen.routeName,
                            builder: (_, state) => ThreeScreen(),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ],
        
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 3.2 버전 이후로 사용해줘야 함
      // 라우트 정보를 전달하는 역할을 함
      routeInformationProvider: _router.routeInformationProvider,
      // URI String을 상태 및 Go Router에서 사용할 수 있는 형태로 반환해주는 함수
      routeInformationParser: _router.routeInformationParser,
      // 위에서 변경된 값으로 실제로 어떤 라우트를 보여줄지 정하는 함수
      routerDelegate: _router.routerDelegate,
    );
  }
}
