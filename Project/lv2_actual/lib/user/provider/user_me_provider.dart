import 'dart:html';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/provider/secure_storage.dart';
import 'package:lv2_actual/user/model/user_model.dart';
import 'package:lv2_actual/user/repository/auth_repository.dart';
import 'package:lv2_actual/user/repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  // 로그인 시도 및 토큰 생성
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);


  return UserMeStateNotifier(authRepository: authRepository, storage: storage, repository: userMeRepository);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  UserMeStateNotifier(
      {required this.authRepository,
      required this.storage,
      required this.repository})
      : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // 최소한 RefreshToken과 AccessToken이 있어야만 getMe 요청을 보낼 수 있음
    if (refreshToken == null || accessToken == null) {
      // 토큰이 없으면 state 상태를 null로 바꿔줘야 함
      state = null;
      return;
    }

    final resp = await repository.getMe();
    state = resp; // 상태에 UserModel 저장
  }

  Future<UserModelBase /*로그인을 요청 했는데 어떤 상태를 받을지 모르기 때문에*/ > login(
      {required String username, required String password}) async {
    try {
      state = UserModelLoading();

      // 로그인 시도
      final resp =
          await authRepository.login(username: username, password: password);

      // accessToken과 refreshToken을 저장
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refershToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      // 로그인 성공시 그 토큰에 해당하는 사용자의 정보를 가져와서 기억을 해둠
      final userResp = await repository.getMe();
      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: e.toString());
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    // 안에 리스트 다 실행 끝나면 다음 코드 실행
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);
  }
}
