import 'package:flutter/cupertino.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

import '../component/render_color_container.dart';
import '../const/colors.dart';

class GridViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Grid View Screen', body: renderCount());
  }

  // 전부 다 한꺼번에 그림.
  Widget renderCount() {
    return GridView.count(
        crossAxisCount: 2, // 가로 뷰 갯수
        crossAxisSpacing: 12.0, // 가로 간격
        mainAxisSpacing: 12.0, // 가로 간격
        children: numbers
            .map(
              (e) => RenderColorContainer(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          ),
        )
            .toList());
  }

  // 보이는 것만 그림.
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2 // 가로로 뷰 갯수 지정함
      ),
      itemBuilder:(context, index) {
        return RenderColorContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderMaxExtent() {
    return MainLayout(
      title: 'GridViewScreen',
      body: GridView.builder(
        itemCount: 100,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50, // 최대 크기가 50이 되는 한도 내에서 가로로 꽉 채움.
        ),
        itemBuilder:(context, index) {
          return RenderColorContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
      ),
    );
  }
}
