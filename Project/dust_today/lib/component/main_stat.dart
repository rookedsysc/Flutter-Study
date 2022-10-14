import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  // 미세먼지 / 초미세먼지 등
  final String category;
  // 아이콘 위치 (경로)
  final String imgPath;
  // 오염 정도
  final String level;
  // 오염 수치
  final String stat;
  const MainStat(
      {required this.category,
      required this.level,
      required this.imgPath,
      required this.stat,
      super.key});

  @override
  Widget build(BuildContext context) {
    final _ts = TextStyle(color: Colors.black);
    return Column(
      children: [
        Text(
          category,
          style: _ts,
        ), 
        SizedBox(
          height: 8.0,
        ),
        Image.asset(
          imgPath,
          width: 50.0,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          level,
          style: _ts,
        ), 
        Text(
          stat,
          style: _ts,
        )
      ],
    );
  }
}