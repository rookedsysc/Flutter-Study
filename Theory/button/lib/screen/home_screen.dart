import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedButton = 'Apple';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {},
                /*
                stylFrom을 타고 함수 안에 들어갔을 때 상속받고 있는 것으로 추정되는 class가 ButtonStyle임.
                해당 class를 사용하기 위해선 MaterialProperty라는 interface 옵션을 사용해줘야 함.
                 */
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    /* Material State는 Flutter 전반적으로 (앱, 웹, 데스크탑 앱 전체 포함) 사용하게 되는 기본적인 상태들임.
                    hovered : 호버링 상태 (마우스 커서를 올려놓은 상태) - 모바일 사용 불가
                    focused : 포커스 됐을 때 (텍스트 필드)
                    pressed : 눌렀을 때
                    dragged : 드래그 됐을 때 (o)
                    selected : 선택됐을 때 (체크박스, 라디오 버튼)
                    scrollUnder : 다른 컴포넌트 밑으로 스크롤링 됐을 때
                    diabled : 비활성화 됐을 때 (Button에서 onPressed: null 해버리면 비활성화 상태가 됨.) (o)
                    error : 에러상태 (텍스트 필드에서 많이 사용함.)
                     */
                    // states에 MaterialState의 상태 값을 담고 있음.
                    // 즉, states에 MaterialState.pressed 상태값을 포함 중이라면 if 문 진입
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    // resolveWith를 사용하게되면 함수를 넣어줘야 하므로 반드시 return 값을(null 이라도) 가져야 함.
                    return Colors.red;
                  }),
                  padding: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return EdgeInsets.symmetric(vertical: 200);
                      }
                      return EdgeInsets.all(20.0);
                    },
                  ),
                ),
                child: Text('ButtonStyle')),
            // ElevatedButton은 ElevatedButton.styleFrom 안에서 스타일 지정가능함.
            // 즉, 해당하는 각각의 Button에 해당하는 StyleFrom을 사용해줘야 함.
            ElevatedButton(
              onPressed: () {},
              child: Text('ElevatedButton'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // 메인 컬러.
                onPrimary: Colors.black, // 글자 색상, button 눌렀을 때 애니메이션 효과.
                shadowColor: Colors.green, // 그림자 색상.
                elevation: 10.0, // z축으로 더 튀어나오게 만들 수 있음. (3D 입체감의 높이)
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
                // Text Style의 padding
                padding: EdgeInsets.all(32.0),
                side: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ), // 테두리
              ),
            ), // 약간 3D 형로 돌출되어 있고 배경 있음.
            OutlinedButton(
              onPressed: () {},
              child: Text('OutlinedButton'),
              style: OutlinedButton.styleFrom(
                // 글자와 애니메이션 효과의 색상을 변경해줌.
                // 배경 색상은 backgroundColor에 넣어서 사용가능하긴 함, 근데 그러면 OutlinedButton을 사용하는 이유가 없음.
                primary: Colors.green,
              ),
            ), // 배경 없이 outline만 있음.
            TextButton(
              onPressed: () {},
              child: Text('TextButton'),
              style: TextButton.styleFrom(
                  primary: Colors.blueAccent // 마찬가지로 글자랑 애니메이션만 색상이 바뀜.
                  ),
            ), // 아무것도 없고 Text만 있음.

            DropdownButton<String>(
                value: selectedButton,
                isDense: true,
                elevation: 16,
                items: ['Apple', 'Cherry', 'Mango']
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ))
                    .toList(),
                onChanged: (String? val) {
                  setState(() {
                    if (val != null) {
                      selectedButton = val!;
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
