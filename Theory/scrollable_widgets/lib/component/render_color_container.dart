import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RenderColorContainer extends StatelessWidget {
  final Color color;
  const RenderColorContainer({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: color,
    );
  }
}
