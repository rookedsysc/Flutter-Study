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
          child: Container(
            width: MediaQuery.of(context).size.width, // 화면 전체 가로 사이즈
            child: Column(
              children: [
                Text(
                  'U & I',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'parisienne',
                    fontSize: 80,
                  ),
                ),
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
                IconButton(
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
          ),
        ));
  }
}
