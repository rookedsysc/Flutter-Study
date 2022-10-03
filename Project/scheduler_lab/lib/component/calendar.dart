import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  DateTime? focusedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false, // 주, 2주, 월로 보기
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
      ),
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
        });
      }),
      // 선택된 날짜가 맞는지 Boolean값으로 넣어줌.
      // true값을 return 받으면 해당 값 Calendar에 표시해줌.
      selectedDayPredicate: (DateTime dateTime) {
        if (selectedDay == null) {
          return false;
        }
        return dateTime.year == selectedDay!.year &&
            dateTime.month == selectedDay!.month &&
            dateTime.day == selectedDay!.day;
      },
    );
  }
}
