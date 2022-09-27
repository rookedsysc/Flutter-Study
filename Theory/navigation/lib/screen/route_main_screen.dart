import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';

class RouteMainScreen extends StatelessWidget {
  const RouteMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Main Route Screen', children: [
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'))
    ],);
  }
}
