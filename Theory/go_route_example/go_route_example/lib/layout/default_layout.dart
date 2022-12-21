


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  const DefaultLayout({required this.body,super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context); 
    debugPrint('router.location: ${router.location}');

    return Scaffold(
      appBar: AppBar(
        title: Text(router.location),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: body,
        ),
      ),
    );
  }
}