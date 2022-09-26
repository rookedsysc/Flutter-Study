import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_number_generator/contant/color.dart';
import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [123, 456, 789];
  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          // Column을 padding으로 감싸줘서 Column과 화면사이의 간격을 둠.
          /*
          All: 사방에 같은 간격을 줌,
          formLTRB(left, top, right, bottom)
          only(named parameter)
          sysmmetric(horizontal, vertical): 가로 / 세로
           */
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _Header(onPressed: onPopSetting),
            _Body(randomNumbers: randomNumbers),
            _Footer(onPressed: onRandomNumberGenerate),
          ]),
        ),
      ),
    );
  }

  void onPopSetting() async { // await 사용하기 위해서 async 상속.
    // 화면을 이동하기 위해서 사용하는 Class.
    // 미래의 특정한 시점(pop)될 때 받을 값이므로 await 사용.
    // push에다가 돌려받을 값의 generic을 지정해줄 수도 있음.
    final result = await Navigator.of(context).push<int>( // 항상 navigation에서 return 해주는 값은 null 값이 있을 수도 있다는 것은 가정.
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen(); // context에 Screen을 반환해줌.
        },
      ),
    );
    // 뒤로 가기 버튼을 누르게 되면 result에 null값이 들어가게 됨.
    if (result != null) {
      setState(() { // build해서 재실행 해줘야 하는 값들은 항상 setState를 통해서 넘겨줘야 함.
        maxNumber = result;
      });
  }}

  // setState를 Stateless Widget에서 사용할 수 없기 때문에 여기로 옮겨준거임.
  void onRandomNumberGenerate() {
    // 버튼을 누를 때마다 1000이하의 숫자 3개를 리스트로 생성해줌.
    final rand = Random();
    final Set<int> newNumbers = {}; // 리스트로 값을 받게 되면 중복 값이 들어감.
    // for문을 사용하게 되면 중복값이 들어갔을 때 최종적으로 2개만 들어가 있게 됨. (Set 특성상)
    while (newNumbers.length < 3) {
      final number = rand.nextInt(maxNumber); // nextInt(1000) > 최대값.
      newNumbers.add(number);
    }

    // 값이 바뀔 때마다 setState가 실행되면서 randomNumbers에 난수 넣어주고 rebuilding됨.
    setState(() {
      randomNumbers = newNumbers.toList(); // List > Set로 넣음.
      print(randomNumbers);
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed; // onPressed Button을 main class에서 직접 받기
  const _Header({required this.onPressed, Key? key}) : super(key: key); // structor 설정

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        '랜덤 숫자 생성기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
      IconButton(
        // 설정 버튼
        onPressed: onPressed,
        icon: Icon(
          Icons.settings,
          color: redColor,
        ),
      ),
    ]);
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          // 가운데 부분의 숫자가 남은 공간 전부를 차지함.
          mainAxisAlignment: MainAxisAlignment.center,
          children: randomNumbers
              .asMap()
              .entries // List > asMap 형식으로 변경하면 Key(index 번호): Value(원래 있던 값)으로 바뀜.
              .map(
                (x) => Padding(
                  padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                  // Index(x.key)가 2라면 0을 넣고 아니라면 16.0을 넣어라.
                  child: Row(
                    children: x
                        .value // Map 형태로 변경해줬기 때문에 Map(index number: value)에서 value 값만 따옴.
                        .toString()
                        .split('')
                        .map(
                          (e) => Image.asset(
                            'asset/img/$e.png',
                            height: 70.0,
                            width: 50.0,
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
              .toList()),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // SizedBox는 너비와 높이만 정할 수 있음. 간단한 대신 정~~~말 조금 더 빠름.
      width: double.infinity, // 무한대 값을 넣어줘도 삐져나가지 않음
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: redColor, // 활성화 됐을 때의 색상
        ),
        onPressed: onPressed,
        child: Text('생성하기!'),
      ),
    );
  }
}
