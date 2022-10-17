import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/utils/data_utils.dart';
import 'package:flutter/material.dart';

import 'card_title.dart';
import 'main_card.dart';

class HourlyCard extends StatelessWidget {
  const HourlyCard(
      {
        required this.darkColor,
        required this.lighColor,
        required this.category,
        required this.region,
        required this.stats,
        super.key});
  final Color darkColor;
  final Color lighColor;
  final String category;
  final String region;
  final List<StatModel> stats;

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lighColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 ${category}',
            backgroundColor: darkColor,
          ),
          Column(children: stats.map(
                  (stat) => renderRow(stat: stat)
          ).toList()),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}) {
    final statusLevel = DataUtils.getStatusFromItemCodeAndValue( // 값에 해당 되는 상태의 statusLevel을 가져옴
        value: stat.getLevelFromRegion(region),
        itemCode: stat.itemCode);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text('${stat.dataTime.hour}시')),
          Expanded(
              child: Image.asset(
                statusLevel.imagePath, // statusLevel.imagePath
                height: 20.0,
              )),
          Expanded(
              child: Text(
                statusLevel.label,
                textAlign: TextAlign.end,
              ))
        ],
      ),
    );
  }
}
