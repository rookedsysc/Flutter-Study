import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/product/view/product_screen.dart';
import 'package:lv2_actual/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

// SingleTickerProviderStateMixin은 Animation을 사용할 때 필요한 Mixin이다.
// 해당 클래스를 상속한 다음 애니메이션 컨트롤러 생성자에게 vsync: this를 넘겨줘야 한다
class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  // late : 나중에 해당 값을 쓸건데 값을 사용할 때는 값이 있을 것이다.
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();

    // vsync: 렌더링 엔진에서 필요한 것
    // controller를 선언하는 현재 state
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListner);
  }

  void tabListner() {
    setState(() {
      // 컨트롤러의 인덱스를 현재 인덱스에 넣어주겠다.
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          Center(
            child: Container(
              child: Text('주문'),
            ),
          ),
          Center(
            child: Container(
              child: Text('프로필'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.shifting, // 선택된 탭이 조금 더 크게 보이게 만듬

        // 선택된 탭의 인덱스가 들어가게 됨
        onTap: (int index) {
          debugPrint(index.toString());
          // TabBarView의 해당하는 인덱스로 움직여라
          controller.animateTo(index);
        },
        currentIndex: index,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}

