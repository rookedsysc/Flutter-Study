import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'HomeScreen', children: [
      ElevatedButton(onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext cotnext) => RouteMainScreen()),
        );
      }, child: Text('Push'))
    ]);
  }
}
