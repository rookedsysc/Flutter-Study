import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:scheduler_lab/component/calendar.dart';
import 'package:scheduler_lab/component/schedule_card.dart';
import 'package:scheduler_lab/component/today_banner.dart';
import 'package:scheduler_lab/component/schedule_bottom_sheet.dart';
import 'package:scheduler_lab/const/colors.dart';
import 'package:scheduler_lab/datebase/drift_database.dart';
import 'package:scheduler_lab/model/schedule_with_color.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 처음에 선택된 날짜는 locale 기준으로 표시가 되지만, onDaySelected에서는 utc기준으로 데이트를 픽함.
  DateTime selectedDay = DateTime.utc(
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
            _Schedule(selectedDay: selectedDay,)
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
          return ScheduleBottomSheet(selectedDate: selectedDay,);
        });
      }, child: Icon(
        Icons.add,
      ));
    }
}

class _Schedule extends StatelessWidget {
  final DateTime selectedDay;
  const _Schedule({required this.selectedDay, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Schedule>? schedules;
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
            builder: (context, snapshot) {
              print('실제로 불러온 전체 데이터 확인 : ${snapshot.data}');

              // 데이터가 아예 없으면 로딩창 뜸.
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }

              // 데이터가 있긴 있는데 비어 있으면.
              if(snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(child: Text('스케줄이 없습니다.'),);
              }

              return ListView.separated(
                // 생성되는 List 사이에 SizedBox를 넣어줌
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 4.0,
                    );
                  },
                  itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                  itemBuilder: (context, index) {
                    // <Schedule>에서 <ScheduleWithColor>로 바뀜.
                    final scheduleWithColor = snapshot.data![index];
                    return ScheduleCard(
                        color: Color(int.parse('FF${scheduleWithColor.categoryColor.hexCode}', radix: 16)),
                        content: scheduleWithColor.schedule.content,
                        startTime: scheduleWithColor.schedule.starttime,
                        endTime: scheduleWithColor.schedule.endTime
                    );
                },);
            }
          )),
    );
  }
}

