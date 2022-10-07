import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_lab/const/colors.dart';
import '../datebase/drift_database.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduleCount;
  const TodayBanner({required this.selectedDay, required this.scheduleCount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Schedule>? schedules;

    final textStyle = TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white
    );
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
                style: textStyle,),
                Text('0개', style: textStyle,),
              ],
        ),
      ),
    );
  }
}
