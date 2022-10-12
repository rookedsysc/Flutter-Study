import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scrollable_widgets/component/render_color_container.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'List View Screen',
        body: renderSeperateExam());
  }

  // 모든 뷰를 한 qjsdp
  Widget renderDefault() {
    return ListView(
      physics: BouncingScrollPhysics(),
        children: numbers
            .map(
              (e) => RenderColorContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList());
  }
  
  // 보이는 것만 빌드됨.
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        print(index); // 새로운 뷰가 호출될 때마다 생성
      return RenderColorContainer(color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  // 기본 seperate Render
  Widget renderSeperated() {
    return ListView.separated(itemBuilder: (context, index){
      return RenderColorContainer(index: index,
          color: rainbowColors[index % rainbowColors.length]);
    }
        , separatorBuilder: (context, index){
      return RenderColorContainer(index:index, color: Colors.black, height: 50,);
        }, itemCount: 100);
  }

  // 5칸 마다 광고
  Widget renderSeperateExam() {
    return ListView.separated(itemBuilder: (context, index){
      return RenderColorContainer(index:index, color: rainbowColors[index % rainbowColors.length]);
    }
        , separatorBuilder: (context, index){
      if( (index != 0) && (index % 5 == 0)) {
        return RenderColorContainer(index: index, color: Colors.black, height: 50,);
      }
      return Container();
        }, itemCount: 100);
  }
}
