import 'package:flutter/material.dart';
import 'package:navigation/screen/route_main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ElevatedButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => RouteMainScreen(),)
            );
          }, child: Text('Push'))],
        ),
      ),
    );
  }
}