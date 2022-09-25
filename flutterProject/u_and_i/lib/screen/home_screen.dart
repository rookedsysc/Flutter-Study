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

class _TopPart extends StatelessWidget {
  const _TopPart({Key? key}) : super(key: key);

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
                '2451-09-24',
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
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+1',
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
