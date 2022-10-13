import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../const/color.dart';
import '../const/custom_font.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            // marign은 padding과 다르게 container 밖의 범위를 지줌해줌
            margin: EdgeInsets.only(
                top: kToolbarHeight), // kToolbarHeight은 Toolbar의 크기
            child: Column(
              children: [
                Text(
                  // 날짜
                  '서울',
                  style: ts.copyWith(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  // 날짜
                  DateTime.now().toString(),
                  style: ts.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'asset/img/mediocre.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '보통',
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '나쁘지 않네요!',
                  style: ts.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
