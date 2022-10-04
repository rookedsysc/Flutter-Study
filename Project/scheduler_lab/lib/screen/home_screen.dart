import 'package:flutter/material.dart';
import 'package:scheduler_lab/component/calendar.dart';
import 'package:scheduler_lab/component/schedule_card.dart';
import 'package:scheduler_lab/component/today_banner.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(onDaySelected: onDaySelected, selectedDay: selectedDay, focusedDay: focusedDay),
            SizedBox(height: 8,),
            TodayBanner(selectedDay: selectedDay, scheduleCount: 3),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                      // 생성되는 List 사이에 SizedBox를 넣어줌
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 4.0,
                        );
                      },
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return ScheduleCard(
                            color: Colors.orange,
                            content: 'content',
                            startTime: 7,
                            endTime: 8);
                      })),
            )
          ],
        ),
      ),
    );
  }
  onDaySelected(selectedDay, focusedDay) {
      setState(() {
        this.selectedDay = selectedDay;
        // 이전 or 이후의 달을 선택하게 되면 해당 월로 focus 이동함.
        this.focusedDay = selectedDay;
      });
    }
}
