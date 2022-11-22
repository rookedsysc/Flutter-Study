import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  const DefaultLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}