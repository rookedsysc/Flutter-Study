import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/riverpod/listen_provider.dart';

class ListenProviederScreen extends ConsumerStatefulWidget {
  // 여기 변경
  const ListenProviederScreen({super.key});

  @override
  // 여기 변경
  ConsumerState<ListenProviederScreen> createState() =>
      _ListProviederScreenState();
}

class _ListProviederScreenState extends ConsumerState<ListenProviederScreen>
    with TickerProviderStateMixin {
  // 여기 변경
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
        length: 10, vsync: this, 
        initialIndex: ref.read(listenProvider)); 
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(listenProvider, (previous, next) {
      if(previous != next) {
        controller.animateTo(next,);
      }
    });
    
    return DefaultLayout(
      title: 'Listen Provieder Screen',
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), // scroll로 이동이 안되게 설정
        controller: controller,
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(index.toString(),textAlign: TextAlign.center,),
              ElevatedButton(onPressed: (){
                ref.read(listenProvider.notifier).update((state) => state == 10 ? 10 : state + 1);
              }, child: Text('Next'),),
              ElevatedButton(onPressed: (){
                ref.read(listenProvider.notifier).update((state) => state == 0 ? 0 : state - 1);
              }, child: Text('Previous'),)
              ],
          ),
        ),
      ),
    );
  }
}

class Test extends ConsumerStatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  ConsumerState<Test> createState() => _TestState();
}

class _TestState extends ConsumerState<Test> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

