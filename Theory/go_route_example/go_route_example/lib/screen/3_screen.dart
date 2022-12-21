import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_route_example/layout/default_layout.dart';

class ThreeScreen extends StatelessWidget {
  const ThreeScreen ({super.key});
  // Go Router의 name: 에 들어갈 이름을 getter로 지정함
  static String get routeName => 'three';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        children: [],
      ),
    );
  }
}