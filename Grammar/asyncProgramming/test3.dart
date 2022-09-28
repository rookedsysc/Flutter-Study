import 'dart:async';

void main() {
  playAllStream().listen((val){
    print(val);
  });
}

Stream<int> playAllStream() async* {
  // yield와 비슷한 동작을 하지만, 뒤에 stream의 return 값이 모두 넘어온 이후에 그 다음 동작을 함. (Future의 await와 비슷)
  yield* calculate(1);
  yield* calculate(1000);
}

Stream<int> calculate(int number) async* {
  for(int i = 0; i < 5; i++){
    // return과 비슷한 동작을 하는데 한 번에 하나씩 return함과 동시에 함수가 종료되지 않고 계속 열려있으면서 지속적으로 return을 해줌.
    yield i * number; 

    // 각각의 stream에서 연산을 할 때 3초의 간격을 둠
    await Future.delayed(Duration(seconds: 3));
  }
}