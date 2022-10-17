import 'package:dust_today/component/card_title.dart';
import 'package:dust_today/component/main_card.dart';
import 'package:dust_today/model/stat_and_status_model.dart';
import 'package:dust_today/utils/data_utils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../const/color.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.models,
    required this.region,
    required this.lightColor,
    required this.darkColor,
    super.key});
  final String region;
  final List<StatAndStatusModel> models;
  final Color lightColor;
  final Color darkColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // height 정해주지 않으면 ListView에서 Error 남.
      child: MainCard(
        backgroundColor: lightColor,
        // LayoutBuilder가 감싸고 있는 곳의 크기를 Constraints에 넣어줌
        child: LayoutBuilder(builder: (context, Constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 카드 제목
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              // ListView는 Epxnaded 안에 들어가야 함.
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models.map((model) => 
                  MainStat(
                          width: Constraints.maxWidth / 3,
                          // itemCode > 한글화
                          category: DataUtils.getItemCodeKrString(itemCode: model.itemCode), 
                          level: model.status.label,
                          imgPath: model.status.imagePath,
                          stat:
                              // itemCode > 단위 
                              '${model.stat.getLevelFromRegion(region)} ${DataUtils.getUnitFromItemCode(itemCode: model.itemCode)}',
                        ),
                      )
                      .toList(),
                  // children: List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //       // Column(Card)의 1/3 만큼 사이즈 넣어줌
                  //       width: Constraints.maxWidth / 3 , 
                  //       category: index.toString(),
                  //       level: '최고',
                  //       imgPath: 'asset/img/best.png',
                  //       stat: '0㎍/㎥'),
                  // ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
