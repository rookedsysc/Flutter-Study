import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_widgets/component/render_color_container.dart';
import 'package:scrollable_widgets/component/render_numbers.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class RefreshIndicatorScreen extends StatelessWidget {
  const RefreshIndicatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Refresh Indicator Screen",
      body: RefreshIndicator(
        // refresh 실행하면 실행될 함수
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: ListView(
          children: renderNumbers.map(
            (e) => RenderColorContainer(
              index: e,
              color: rainbowColors[e % rainbowColors.length],
            ),
          ).toList(),
        ),
      ),
    );
  }
}
