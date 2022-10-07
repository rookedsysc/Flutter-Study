import 'package:scheduler_lab/datebase/drift_database.dart';

class ScheduleWithColor {
  // 우리가 생성해준 Schedules가 아니라 자동 생성된 Schedule의 데이터를 받아올 것이기 때문에 Schedule 형태로 받음.
  final Schedule schedule;
  final CategoryColor categoryColor;

  ScheduleWithColor({
    required this.schedule, required this.categoryColor
  });
}