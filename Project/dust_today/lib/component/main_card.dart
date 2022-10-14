import 'package:flutter/material.dart';

import '../const/color.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  MainCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
        shape: RoundedRectangleBorder(
            // Card의 테두리를 둥글게 해줌
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        color: lightColor,
        child: child,
    );
  }
}