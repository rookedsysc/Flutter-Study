import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RenderColorContainer extends StatelessWidget {
  final Color color;
  final int index;
  double? height;
  RenderColorContainer(
      {this.height, required this.index, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    if (index != null) {
      print('index number : $index');
    }
    return Container(
        key: Key(index.toString()),
        height: height ?? 200,
        color: color,
        child: index != null
            ? Center(
                child: Text(
                index.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0),
              ))
            : Center(child: Text('index is emty'),));
  }
}
