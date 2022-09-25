import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        // 100 ~ 900 까지 설정 가능 낮아질 수록 색상이 점점 연해짐.
        body: SafeArea(
          bottom: false, // SafeArea Bottom에는 적용하지 않음.
          child: Container(
            width: MediaQuery.of(context).size.width, // 화면 전체 가로 사이즈
            child: Column(
              children: [
                _TopPart(),
                _BottomPart(),
              ],
            ),
          ),
        ));
  }
}

class _TopPart extends StatefulWidget {
  const _TopPart({Key? key}) : super(key: key);

  @override
  State<_TopPart> createState() => _TopPartState();
}

class _TopPartState extends State<_TopPart> {
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // 화면에 꽉 채움 Column 내부의 두 child를 Expanded로 감쌋기 때문에 50/50으로 감싸줌.
    // 여기서 Expanded를 넣는거랑 위에서 넣는거랑 다를바가 없음.
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U & I',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'parisienne',
              fontSize: 80,
            ),
          ),
          // 우리 처음 만난 날 글자와 날짜의 간격이 다른 간격이랑 다르게 만들어주기 위해서 두 개를 또 하나의 Column으로 묶어줌.
          Column(
            children: [
              Text(
                "우리 처음 만난 날",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 30.0,
                ),
              ),
              Text(
                '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sunflower',
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          IconButton(
            iconSize: 100,
            onPressed: () {
              // 화면을 덮는 또 하나의 화면을 만들 수 있게 해줌, 화면 안에 들어갈 위젯을 builder에 넣어줌.
              showCupertinoDialog(
                context: context,
                builder: (BuildContext contecxt) {
                  return Align(
                    // Flutter는 기본적으로 정렬할 위치가 정의되지 않으면 화면 전체를 차지하도록 프로그래밍 되어있음.
                    // Align Widget의 alignment를 통해서 해당하는 부분(showCuperTinoDialog(Button Click시 생성되는 창))에 Bottom.center로 정렬할 위치를 지정해줌.
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      height: 300.0,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,

                        initialDateTime: DateTime(now.year, now.month, now.day), // DatePicker가 처음에 실행될 때 실행되는 날짜, 기본값은 현재 시간.
                        maximumDate: DateTime(now.year, now.month, now.day), // 최대 시간 지정.
                        onDateTimeChanged: (DateTime date){
                          // Sateful Widget에서 변경을 실행할 때 Widget을 통하지 않고 State 내부에서 직접 실행함.
                          setState(() {
                            // 선택한 date값을 넣어줌.
                            selectedDate = date;
                          });
                        }
                        ,
                      ),
                    ),
                  );
                },
                barrierDismissible: true, // 화면 바깥 부분을 누르면 CupertinoDialog 닫힘.
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${
            DateTime(
              now.year,
              now.month,
              now.day,
            ).difference(selectedDate).inDays + 1 // 현재 시간 - selectedDate + 1 (오늘부터 1일)
            }',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'sunflower',
              fontSize: 50.0,
              fontWeight: FontWeight.w700, // 텍스트 굵기
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Image.asset(
      'asset/img/middle_image.png',
    ));
  }
}
