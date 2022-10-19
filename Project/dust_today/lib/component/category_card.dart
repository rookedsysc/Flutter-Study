import 'package:dust_today/component/card_title.dart';
import 'package:dust_today/component/main_card.dart';
import 'package:dust_today/model/stat_and_status_model.dart';
import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/utils/data_utils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../const/color.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.region,
    required this.lightColor,
    required this.darkColor,
    super.key});
  final String region;
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
                  children: ItemCode.values.map((ItemCode itemCode) =>
                  ValueListenableBuilder(
                      valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
                      builder: (context, box, widget) {
                        final stat = (box.values.last as StatModel);
                            final status =
                                DataUtils.getStatusFromItemCodeAndValue(
                                    value: stat.getLevelFromRegion(region),
                                    itemCode: itemCode);

                            return MainStat(
                              width: Constraints.maxWidth / 3,
                              // itemCode > 한글화
                              category: DataUtils.getItemCodeKrString(
                                  itemCode: stat.itemCode),
                              level: status.label,
                              imgPath: status.imagePath,
                              stat:
                                  // itemCode > 단위
                                  '${stat.getLevelFromRegion(region)} ${DataUtils.getUnitFromItemCode(itemCode: stat.itemCode)}',
                            );
                          }))
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
