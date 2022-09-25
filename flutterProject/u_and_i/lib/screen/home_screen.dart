import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 데이터가 여러 곳에 나누어져 있으면 흐름을 보기가 굉장히 힘들어지고 코드를 고치려고 했을 때 어디에서 어떤 데이터를 고쳐야 할지 찾아야함.
// 따라서 데이터를 최상위에서 관리해주는게 중요함.
/* 최상위로 데이터 옮기는 순서
1. TopPart Stateless Widget으로 변경.
2. TopPart에 있던 Data들 전부 HomeScreen State로 옮겨줌.
3. TopPart에서 오류 안나게 설정.
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

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
              _TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    DateTime now = DateTime.now();
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

              // DatePicker가 처음에 실행될 때 실행되는 날짜, 기본값은 현재 시간.
              initialDateTime: DateTime(now.year, now.month, now.day),

              onDateTimeChanged: (DateTime date) {
                // Sateful Widget에서 변경을 실행할 때 Widget을 통하지 않고 State 내부에서 직접 실행함.
                setState(() {
                  // 선택한 date값을 넣어줌.
                  selectedDate = date;
                });
              },
              // 최대 시간 지정.
              maximumDate: selectedDate,
            ),
          ),
        );
      },
      barrierDismissible: true, // 화면 바깥 부분을 누르면 CupertinoDialog 닫힘.
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime now = DateTime.now();
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({required this.selectedDate, required this.onPressed, Key? key})
      : super(key: key);

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
            onPressed: onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${DateTime(
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
