import 'package:flutter/material.dart';
import 'package:random_number_generator/contant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          // Column을 padding으로 감싸줘서 Column과 화면사이의 간격을 둠.
          /*
          All: 사방에 같은 간격을 줌,
          formLTRB(left, top, right, bottom)
          only(named parameter)
          sysmmetric(horizontal, vertical): 가로 / 세로
           */
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                '랜덤 숫자 생성기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                // 설정 버튼
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: redColor,
                ),
              ),
            ]),
            Expanded(
              child: Column(
                  // 가운데 부분의 숫자가 남은 공간 전부를 차지함.
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    123,
                    456,
                    789,
                  ]
                      .map(
                        (x) => Row(
                          children: x
                              .toString()
                              .split('')
                              .map(
                                (e) => Image.asset(
                                  'asset/img/$e.png',
                                  height: 70.0,
                                  width: 50.0,
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList()),
            ),
            SizedBox(
              // SizedBox는 너비와 높이만 정할 수 있음. 간단한 대신 정~~~말 조금 더 빠름.
              width: double.infinity, // 무한대 값을 넣어줘도 삐져나가지 않음
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: redColor, // 활성화 됐을 때의 색상
                ),
                onPressed: () {},
                child: Text('생성하기!'),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
