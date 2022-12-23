import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/user/model/user_model.dart';
import 'package:lv2_actual/user/repository/user_me_repository.dart';

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  UserMeStateNotifier({required this.storage, required this.repository}): super(
    UserModelLoading()
  ) {
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    
    // 최소한 RefreshToken과 AccessToken이 있어야만 getMe 요청을 보낼 수 있음
    if(refreshToken == null || accessToken == null) {
      // 토큰이 없으면 state 상태를 null로 바꿔줘야 함
      state = null; 
      return; 
    }

    final resp = await repository.getMe();
    state = resp; // 상태에 UserModel 저장 
  }
}