import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_route_example/model/user_model.dart';
import 'package:go_route_example/screen/1_screen.dart';
import 'package:go_route_example/screen/2_screen.dart';
import 'package:go_route_example/screen/3_screen.dart';
import 'package:go_route_example/screen/err_screen.dart';
import 'package:go_route_example/screen/home_screen.dart';
import 'package:go_route_example/screen/login_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateProvider = AuthNotifier(ref: ref);

  return GoRouter(
      // 홈스크린
      initialLocation: '/login',
      redirect: authStateProvider._redirectLogic,
      // 상태가 바뀌었을 때마다 redirect를 재실행해줌
      //
      // 예를 들어,
      // 중간에 토큰이 만료되었을 때 login 화면으로 이동
      refreshListenable: authStateProvider,
      // 네이게이션 과정 중에서 에러가 발생했을 때
      // state에 에러 메시지가 들어가고
      // ErrScreen으로 이동
      errorBuilder: (_, state) => ErrScreen(err: state.error.toString()),
      routes: authStateProvider._routes);
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;
  AuthNotifier({required this.ref}) {
    // user model의 값이 바뀌면 call back 함수를 실행
    ref.listen<UserModel?>(
      userProvider,
      (previous, next) {
        if (previous != next) {
          // notifyListeners()를 호출하면 ChangeNotifier를 바라보고 있는 모든 위젯들이 다 리빌드 됨
          notifyListeners();
        }
      },
    );
  }

  // redirect logic
  // GoRouterState : 현재 라우트의 상태
  String? _redirectLogic(GoRouterState state) {
    final user = ref.read(userProvider); // instance or null
    // 로그인을 하려는 상태인지
    final logginIn = state.location == '/login';

    // 유저 정보가 없다 - 로그인한 상태가 아니다
    //
    // 유저 정보가 없고
    // 로그인하려는 중이 아니라면
    // 로그인 페이지로 이동한다.
    if (user == null) {
      // redirect에 넣었을 때
      //
      // logginIn이 true면 원래 가려던 페이지로 이동
      // false면 로그인 페이지로 이동
      return logginIn ? null : '/login';
    }

    // 유저 정보가 있는데
    // 로그인 페이지일 때 홈으로 이동
    if (logginIn) {
      return '/';
    }

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
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
        GoRoute(path: '/login', builder: (_, state) => LoginScreen()),
      ];
}

final userProvider =
    StateNotifierProvider<UserStateNotifier, UserModel?>((ref) {
  return UserStateNotifier();
});

// 로그인 시에는 user name을, 로그아웃 시에는 null을 state로 가지는 StateNotifier
class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  login(String name) {
    state = UserModel(name: name);
  }

  logout() {
    state = null;
  }
}
