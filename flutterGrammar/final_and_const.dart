void main() {
  final String name  = "flutter 프로그래밍";
  print(name);
  // name = "파이널로 선언 된 변수는 값을 바꿀 수 없음"; // 파이널로 선언 된 변수는 값을 바꿀 수 없음

  const String name2 = "블랙핑크";
  print(name2); 
  // name2 = "const로 선언된 것도 값을 바꿀 수 없음"; // const로 선언된 것도 값을 바꿀 수 없음

  final stringName = "독거노인"; // var처럼 타입 추론 가능
  const stringName2  = "아이유"; 
  
  // final과 const의 차이점
  customDateTime();
}

void customDateTime() {
    // final은 build time의 값을 알고 있지 않아도 됨
    final DateTime now = DateTime.now(); // 코드를 실행하는 순간에 시간을 저장함
    print(now);

    /* const 타입은 build time의 값을 알고 있어야 함.(build가 되는 순간에 어떤 값인지 알고 있어야 함.)
    그러나 DateTime.now()는 빌드가 되는 순간에 값이 정해지기 때문에 에러가 발생하는 것임 */
    // const DateTime now2 = DateTime.now(); // 오류 발생
}