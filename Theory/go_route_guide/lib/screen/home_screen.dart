import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_route_guide/main.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen"),),
      body: Column(
        children: [
          IconButton(onPressed: (){
            return context.go('/homescreen/details');
          }, icon: Icon(Icons.home))
        ],
      ),
    );
  }
}

 