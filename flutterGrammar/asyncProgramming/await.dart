void main() async {
  // Future - 미래
  // 미래에 받아올 값
  Future<String> name = Future.value('아이유');
  Future<int> number = Future.value(2);
  Future<bool> isTrue = Future.value(true);

  print('함수 시작');
  final result1 = await addNumbers(1, 1);
  final result2 = await addNumbers(2, 2);
  print('result1 + result2 : ${result1 + result2}');
}

// await를 사용하기 위해선 함수에다가 async를 추가해야지 사용할 수 있음.
Future<int> addNumbers(int number1, int number2) async {
  print('계산 시작 : $number1 + $number2');

  // 서버 시뮬레이션
  await Future.delayed(Duration(seconds: 2), () {
    // 여기에서 코드를 더 실행하지 않고 기다림(해당 함수에서만 적용).
    print('계산 완료 : $number1 + $number2 = ${number1 + number2}');
  });

  print('함수 완료'); // 함수 완료 먼저 출력됨.

  return number1 + number2;
}
