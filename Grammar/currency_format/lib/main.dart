import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(simpleCurrnecyFormat(1234567890)),
    ));
  }

  String simpleCurrnecyFormat(double num) {
    int operand = 1000;
    int cnt = 0;
    String si = ''; // si 단위
    while (num / operand >= 1) {
      operand = operand * 1000;
      cnt += 1;
      print(num/operand);
      if(num / operand < 10000) {
        break;
      }
    }
    var f = NumberFormat("#,###.##");

    switch (cnt) {
      case 0:
        si = 'k';
        break;
      case 1:
        si = 'M';
        break;
      case 2:
        si = 'G';
        break;
      case 3:
        si = 'T';
        break;
      case 4:
        si = 'P';
        break;
      default:
        si = '';
        break;
    }

    print('cnt : $cnt');
    print(operand);
    print(f.format(num/operand));

    return '${f.format(num/operand)} ${si}';
  }
}
