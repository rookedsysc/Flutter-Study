import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:lv2_actual/common/view/root_tab.dart';
import 'package:lv2_actual/restaurant/view/restaurant_screen.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => "orderDone";
  const OrderDoneScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.thumb_up_alt_outlined,
              color: PRIMARY_COLOR,
              size:  50.0,
            ),
            const SizedBox(height: 32.0,),
            Text('결제가 완료되었습니다.', textAlign: TextAlign.center,),
            const SizedBox(height: 32.0,),
            ElevatedButton(onPressed: (){
              context.goNamed(RootTab.routeName);
            }, child: Text('홈으로'), style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),)

          ],
        ),
      ),
    );
  }
}