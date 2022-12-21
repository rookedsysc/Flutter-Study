import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_route_example/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

class ErrScreen extends StatelessWidget {
  final String err;
  const ErrScreen ({required this.err,super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Text(err),
        ElevatedButton(
          onPressed: () {
            context.go('/');
          },
          child: Text('go to /'),
        )
      ],
    ));
  }
}