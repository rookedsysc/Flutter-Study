import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;

  // ImageView Control하기 위한 Controller.
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    // timer를 이용해서 Controller를 조정해주는 부분
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // contoller에서 현재 페이지를 받아옴.
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }

      controller.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear, // 실행 속도, 보통 속도.
      );
    });
  }

  // State의 생명주기의 마지막, 생명주기가 끝날 때 실행됨.
  // Stateful Widget이 닫힐 때 Timer 종료시켜줌.
  @override
  void dispose() {
    super.dispose();
    // controller도 메모리에서 빼줘야 함.
    controller.dispose();

    if (timer != null) {
      // timer가 null이 아닌데 오류 발생함.
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 위에 배터리 표시나 시간 등이 검정색으로 변경됨.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Image.asset(
                'asset/img/image_$e.jpeg',
                // 전체화면, 위아래나 좌우 중 짤려서 나올 수 있음.
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
