import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lv2_actual/common/view/root_tab.dart';
import 'package:lv2_actual/common/view/splash_screen.dart';
import 'package:lv2_actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:lv2_actual/restaurant/view/restaurant_screen.dart';
import 'package:lv2_actual/user/model/user_model.dart';
import 'package:lv2_actual/user/provider/user_me_provider.dart';
import 'package:lv2_actual/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    // 유저가 로딩 중인지, 실제 유저가 존재하는지 등의 값을 알 수 있음
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      // user me provider에서 변경사항이 생겼을 경우
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            // :rid에 인자값을 받아줄 수 있음
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.params['rid']!,
              ),
            ),
          ],
        ),
        // 스플래쉬 스크린
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        // 로그인 스크린
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
      ];

  //: dio 관련된 호출이 없기 때문에 여기서 logout 생성
  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    // 유저 정보가 없는데 로그인 중 => 로그인 페이지
    // 로그인 중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }
    //
    // user가 null이 아님
    //

    // 사용자 정보가 있을 때 로그인 중 or 현재 위치가 Splash => 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    // 로그인 중이 아니라면 로그인 페이지로 이동
    if (user is UserModelError) {
      return !logginIn ? null : '/login';
    }

    // 나머지 경우에는 원래 가던 곳으로 가게 해줌
    return null;
  }
}
