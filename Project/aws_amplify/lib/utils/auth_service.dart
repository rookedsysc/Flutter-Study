import 'dart:async';

// 로그인, 회원가입 등의 인증 흐름을 제공하는 열거형
enum AuthFlowStatus { login, signUp, verification, session }

// 스트림에서 관찰할 실제 객체
class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({required this.authFlowStatus});
}

// AuthState 객체를 관찰할 수 있는 스트림을 제공하는 클래스
class AuthService {
  // AuthState 객체를 관찰할 수 있는 스트림 컨트롤러
  final authStateController = StreamController<AuthState>();

  // AuthState 객체를 추가하는 메서드
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  // Stream을 업데이트해서 로그인 정보를 전송함
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}