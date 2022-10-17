import 'package:flutter/material.dart';

import 'card_title.dart';
import 'main_card.dart';

class HourlyCard extends StatelessWidget {
  const HourlyCard(
      {
        required this.darkColor,
        required this.lighColor,
        super.key});
  final Color darkColor;
  final Color lighColor;

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lighColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 미세 먼지',
            backgroundColor: darkColor,
          ),
          Column(
            children: List.generate(
              24,
              (index) {
                final now = DateTime.now();
                final hour = now.hour;
                int currentTime = hour - index;

                if (currentTime < 0) {
                  currentTime += 24;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text('${currentTime}시')),
                      Expanded(
                          child: Image.asset(
                        'asset/img/good.png',
                        height: 20.0,
                      )),
                      Expanded(
                          child: Text(
                        '좋음',
                        textAlign: TextAlign.end,
                      ))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
