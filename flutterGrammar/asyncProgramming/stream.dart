import 'dart:async';

void main() {
	final controller = StreamController();
  // asBroadcastStream을 이용해줘야 여러번 listening을 할 수 있음.
	final Stream = controller.stream.asBroadcastStream();  

  // 짝수만 출력
  // 리스너 생성, 이 리스너가 리스닝을 하고 있을 때 값이 들어오면 함수가 실행됨.
  final streamListener1 = Stream.where((val) => val % 2 == 0).listen((val){
    print('Listener1 : $val');
  });

  // 홀수만 출력 
  final streamListener2 = Stream.where((val) => val % 2 == 1).listen((val){
    print('Listener2 : $val');
  });

  // controller를 통해서 리스너에 값을 넣어줌
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
}

