import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scrollable_widgets/component/render_color_container.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPerformance(), // 여기에 보고 싶은 위젯 넣기
    );
  }

  // 기본 렌더링
  Widget renderSimple() {
    // 기본은 스크롤이 안되지만, 화면이 길어지면 Scroll이 가능함.
    return SingleChildScrollView(
      child: Column(
        children:
            rainbowColors.map((e) => RenderColorContainer(color: e)).toList(),
      ),
    );
  }

  Widget renderPhysics() {
    return SingleChildScrollView(
      /* 
        Single Child ScrollView가 어떤 방식으로 작용하는지 정할 수 있음.
        AlwaysScrollableScrollPhysics() - 항상 스크롤 가능
        NeverScrollableScrollPhysics()- 절대 스크롤 불가능
        BouncingScrollPhysics() - iOS Style (튕김.)
        ClampingScrollPhysics() - Android Style (튕기지 않음.)
      */
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map(
              (e) => RenderColorContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  // 화면이 짤리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          RenderColorContainer(color: Colors.black),
        ],
      ),
    );
  }

  // SingleChildScrollView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => RenderColorContainer(
                color: rainbowColors[e % rainbowColors.length],
              ),
            )
            .toList(),
      ),
    );
  }
}
