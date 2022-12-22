import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_route_example/layout/default_layout.dart';
import 'package:go_route_example/provider/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                ref.read(userProvider.notifier).login("백종인");
              },
              child: Text('로그인'))
        ],
      ),
    );
  }
}
