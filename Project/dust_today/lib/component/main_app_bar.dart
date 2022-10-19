import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/model/status_model.dart';
import 'package:dust_today/utils/data_utils.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/src/date_format_internal.dart';

import '../const/color.dart';
import '../const/custom_font.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status; // 값에 따라 분류하는 모델
  final StatModel stat; // 실제로 API에서 받아오는 값
  final String region;
  final DateTime dateTime;
  final bool isExpanded;
  const MainAppBar(
      {required this.region,
      required this.stat,
      required this.status,
      required this.dateTime,
      required this.isExpanded,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      // 펼쳐져 있으면 타이틀 안넣고 안펼쳐져 있으면 '도시 시간' 넣어줌
      title: isExpanded ? null : Text('${region} ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}'),
      backgroundColor: status.primaryColor,
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
                  // 도시
                  region,
                  style: ts.copyWith(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  // 날짜
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(fontSize: 20),
                  ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  status.label,
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  status.comment,
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
