import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Color color;

  const HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  // statefulWidget에 필수적으로 들어가는 override.
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> { // HomeScreen의 State라는 것을 명시해줌.
  // State에 필수적으로 들어가야 하는 override.
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      // HomeScreenState가 extend한 State에 존재하는 값임.
      // generic을 통해서 State가 HomeScreen을 명시해줬기 때문에 그 값을 사용할 수 있음.
      color: widget.color,
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
