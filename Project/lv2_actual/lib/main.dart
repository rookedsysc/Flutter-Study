import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/component/custom_text_form_field.dart';
import 'package:lv2_actual/common/provider/go_router.dart';
import 'package:lv2_actual/common/view/splash_screen.dart';
import 'package:lv2_actual/user/provider/auth_provider.dart';
import 'package:lv2_actual/user/view/login_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Notosans',
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,

      routerConfig: route,
    );
  }
}
