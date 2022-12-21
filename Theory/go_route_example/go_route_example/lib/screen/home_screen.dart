import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_route_example/layout/default_layout.dart';
import 'package:go_route_example/screen/3_screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/one');
            },
            child: Text('Screen One (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/one/two');
            },
            child: Text('Screen Two (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).goNamed(ThreeScreen.routeName);
            },
            child: Text('Screen Threee (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/err');
            },
            child: Text('Go To Error'),
          ),

        ],
      ),
    );
  }
}
