import 'package:aws_amplify/login_page/login_page.dart';
import 'package:aws_amplify/sign_up_page/sign_up_page.dart';
import 'package:aws_amplify/utils/auth_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Circular Progress Indicator를 표시하지 않게 값 초기화
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      // Page routing
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {

          if(snapshot.data == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Navigator(
            pages: [
              if(snapshot.data!.authFlowStatus == AuthFlowStatus.login)
                MaterialPage(child: LoginPage()),
              if(snapshot.data!.authFlowStatus == AuthFlowStatus.signUp)
                MaterialPage(child: SignUpPage()),
            ],
            onPopPage: (route, result) => route.didPop(result),
          );
        }
      ),
    );
  }
}
