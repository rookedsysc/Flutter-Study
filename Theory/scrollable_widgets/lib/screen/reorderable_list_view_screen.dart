import 'package:flutter/material.dart';
import 'package:scrollable_widgets/component/render_color_container.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

import '../component/render_numbers.dart';

class ReorderableListViewScreen extends StatefulWidget {
  ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() => _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return renderBuilder();
  }

  Widget renderDefault() {
    return ReorderableListView(
      // 다른 class에 있는 container 가져오면 key 없다고 실행 안됨.
      children: renderNumbers.map((e) => RenderColorContainer(
        key: Key(e.toString()),
        color: rainbowColors[e % rainbowColors.length],
        height: 300,
        index: e,),
      ).toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = renderNumbers.removeAt(oldIndex);
          renderNumbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderBuilder() {
    return MainLayout(
        title: 'Reorderable List View Screen',
        body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return RenderColorContainer(
                key: Key(index.toString()),
                // index number가 이동해도 해당 index는 가만히 있음,
                // 그러나 해당 index에 있던 renderNumber는 바뀌게 됨.
                // 즉, 3에 있던 renderNumber를 5로 보내면 여전히 3번째 인덱스를 봤을 때 3번째 인덱스로 보이지만
                // 해당하는 인덱스에는 renderNumber의 다음 인덱스가 그 인덱스 번호를 차지하게 됨.
                color: rainbowColors[renderNumbers[index] % rainbowColors.length],
                index: renderNumbers[index]);
          },
          itemCount: renderNumbers.length,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              // oldIndex와 newIndex 모두
              // 이동이 되기 전에 산정됨.
              //
              // [red, orange, yellow]
              // [0, 1, 2]
              //
              // red를 yellow 다음으로 옮기고을 경우
              // oldIndex는 0으로 newIndex는 3으로 지정이 됨.
              // [orange, yellow, red]
              // 옮기고 난 후의 Red의 index는 2번이 됨.
              // 따라서 낮은 인덱스를 높은 인덱스로 옮길 때는 newIndex에 -1을 해줘야함.
              //
              // [red, orange, yellow]
              // yellow를 맨 앞으로 옮기고싶다.
              // yellow : 2 oldIndex -> 0 newIndex
              // [yellow, red, orange]
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = renderNumbers.removeAt(oldIndex);
              renderNumbers.insert(newIndex, item);
            });
          },
        ));
  }

}
