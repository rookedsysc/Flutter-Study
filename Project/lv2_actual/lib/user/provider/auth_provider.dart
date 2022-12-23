import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lv2_actual/user/model/user_model.dart';
import 'package:lv2_actual/user/provider/user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}){
    // 유저가 로딩 중인지, 실제 유저가 존재하는지 등의 값을 알 수 있음
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) { 
      // user me provider에서 변경사항이 생겼을 경우
      if(previous != next) {
        notifyListeners();
      }
    });

  }

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    // 유저 정보가 없는데 로그인 중 => 로그인 페이지
    // 로그인 중이 아니라면 로그인 페이지로 이동
    if(user==null) {
      return logginIn ? null : '/login';
    }
    //
    // user가 null이 아님
    //

    // 사용자 정보가 있을 때 로그인 중 or 현재 위치가 Splash => 홈으로 이동
    if(user is UserModel) {
      return logginIn || state.location == '/splash'  ? '/' : null;
    }

    // 로그인 중이 아니라면 로그인 페이지로 이동
    if(user is UserModelError) {
      return !logginIn ? null : '/login';
    }

    // 나머지 경우에는 원래 가던 곳으로 가게 해줌
    return null;
  }
}