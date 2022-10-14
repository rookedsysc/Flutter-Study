import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../const/color.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // height 정해주지 않으면 ListView에서 Error 남.
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        shape: RoundedRectangleBorder(
            // Card의 테두리를 둥글게 해줌
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        color: lightColor,
        // LayoutBuilder가 감싸고 있는 곳의 크기를 Constraints에 넣어줌
        child: LayoutBuilder(builder: (context, Constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 카드 제목
              Container(
                  decoration: BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '종류별 통계',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
              // 카드
              Expanded(
                // ListView는 Epxnaded 안에 들어가야 함.
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: List.generate(
                    20,
                    (index) => MainStat(
                        // Column(Card)의 1/3 만큼 사이즈 넣어줌
                        width: Constraints.maxWidth / 3 , 
                        category: index.toString(),
                        level: '최고',
                        imgPath: 'asset/img/best.png',
                        stat: '0㎍/㎥'),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
