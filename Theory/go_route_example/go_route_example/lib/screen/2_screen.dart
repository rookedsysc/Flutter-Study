import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_route_example/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

class TwoScreen extends StatelessWidget {
  const TwoScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Second Screen'),
          ElevatedButton(onPressed: (){
            context.pop();
          }, child: Text('pop'))
        ],
      ),
    );
  }
}