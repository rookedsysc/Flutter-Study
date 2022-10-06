import 'package:flutter/material.dart';
import 'package:scheduler_lab/component/calendar.dart';
import 'package:scheduler_lab/component/schedule_card.dart';
import 'package:scheduler_lab/component/today_banner.dart';
import 'package:scheduler_lab/component/schedule_bottom_sheet.dart';
import 'package:scheduler_lab/const/colors.dart';


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
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
                onDaySelected: onDaySelected,
                selectedDay: selectedDay,
                focusedDay: focusedDay),
            SizedBox(
              height: 8,
            ),
            TodayBanner(selectedDay: selectedDay, scheduleCount: 3),
            _Schedule()
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
    FloatingActionButton renderFloatingActionButton() {
      return FloatingActionButton(backgroundColor: PRIMARY_COLOR, onPressed: () {
        // showModalBottomSheet는 기본적으로 화면의 절반을 차지하는게 최대값임.
        showModalBottomSheet(
          // isScrollControlled 옵션을 사용해주면 화면 최대 크기까지 showModalBottomSheet가 늘어남.
          isScrollControlled: true,
            context: context, builder: (_){
          return ScheduleBottomSheet();
        });
      }, child: Icon(
        Icons.add,
      ));
    }
}



class _Schedule extends StatelessWidget {
  const _Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}

