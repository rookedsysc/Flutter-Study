import 'package:dust_today/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          ValueListenableBuilder<Box>( // Stream이랑 비슷함 변경사항이 있을 때마다 화면에 즉각 반영됨
              valueListenable: Hive.box(testBox).listenable(), // Listen할 Box
              // Build 되거나 Box의 값이 바뀔 때마다 실행됨
              builder: (context, box, widget) {
                print(box.values.toList());

            return Container();
          }),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(onPressed: () {
              final box = Hive.box(testBox);
              print(" keys : ${box.keys.toList()}");
              print(" value : ${box.values.toList()}");
            }, child: Text("박스 프린트하기!")),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(onPressed: () {
              final box = Hive.box(testBox);

              box.add('테스트');
            }, child: Text("데이터 넣기!")),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(onPressed: () {
              final box = Hive.box(testBox);

              // key / 테스트
              // 존재하는 값이면 덮어씀
              box.put(100,5000);
              box.put(2, true); // NoSQL은 타입에 관계 없이 다 들어감
            }, child: Text("Put으로 데이터 넣기!")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(onPressed: () {
              final box = Hive.box(testBox);

              // print(box.get(100)); // 가져올 value의 key
              print(box.getAt(0)); // key값이 아닌 index 번호
            }, child: Text("특정 값 가져오기")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(onPressed: () {
              final box = Hive.box(testBox);

              print(box.deleteAt(5)); // index로 삭제
              print(box.delete(2)); // key로 삭제
            }, child: Text("삭제하기!")),
          ),
        ],
      ),
    );
  }
}
