import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_route_example/provider/auth_provider.dart';
import 'package:go_route_example/screen/1_screen.dart';
import 'package:go_route_example/screen/2_screen.dart';
import 'package:go_route_example/screen/3_screen.dart';
import 'package:go_route_example/screen/err_screen.dart';
import 'package:go_route_example/screen/home_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App({super.key});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // 3.2 버전 이후로 사용해줘야 함
      // 라우트 정보를 전달하는 역할을 함
      routeInformationProvider: router.routeInformationProvider,
      // URI String을 상태 및 Go Router에서 사용할 수 있는 형태로 반환해주는 함수
      routeInformationParser: router.routeInformationParser,
      // 위에서 변경된 값으로 실제로 어떤 라우트를 보여줄지 정하는 함수
      routerDelegate: router.routerDelegate,
    );
  }
}
