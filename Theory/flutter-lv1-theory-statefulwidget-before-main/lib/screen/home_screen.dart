import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key){
    print('Widget Constructor 실행!');
  }

  // statefulWidget에 필수적으로 들어가는 override.
  @override
  State<StatefulWidget> createState() {
    print('createState 실행!');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> { // HomeScreen의 State라는 것을 명시해줌.
  int number = 0;

  @override
  void initState() {
    super.initState();

    print('initState 실행!');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChagneDependencies 실행!');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate 실행!');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose 실행!');
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget 실행');
  }
  // State에 필수적으로 들어가야 하는 override.
  @override
  Widget build(BuildContext context) {
    print('build 실행!');

    // GestureDetector를 사용하면 화면에서 인식할 수 있는 모든 행동을 다 집어넣을 수 있음.
    return GestureDetector(
      // child 안에 감싸져있는 값에 onTap Action이 감지되었을 때 실행해줄 함수.
      onTap: (){
        print('클릭!');
        setState(() { // 변경하고 싶은 값을 넣어줌.
          print('setState 실행!');
          number += 1;
        });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        // HomeScreenState가 extend한 State에 존재하는 값임.
        // generic을 통해서 State가 HomeScreen을 명시해줬기 때문에 그 값을 사용할 수 있음.
        color: widget.color,
        child: Center(
          child: Text(number.toString()),
        ),
      ),
    );
  }

}


// Show Context Action(option + enter) > Conver to StatefulWidget 을 통해서 쉽게 StatefulWidget으로 변경시켜줄 수 있음.
// stful이라고 입력하면 StatefulWidget 자동 생성해줌.
class _HomeScreen extends StatelessWidget {
  final Color color;

  const _HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: color,
    );
  }
}
