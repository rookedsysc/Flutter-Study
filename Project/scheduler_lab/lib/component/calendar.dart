import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scheduler_lab/const/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  DateTime? focusedDay;

  final defaultBoxDeco = BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(6.0),
  );

  final defaultTextStyle =
      TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700);

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
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false, // 오늘 날짜 highlight

        // 각각의 날짜의 container가 있는 데 그 container의 값을 지정해줌.
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: PRIMARY_COLOR, width: 1.0),
        ),
        // 평일, 주말 글자 스타일
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
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
