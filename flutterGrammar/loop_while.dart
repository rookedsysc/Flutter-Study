void main() {
  int total = 0;

  while(total < 11) {
    print(total);
    total += 1;
  }

  // do - while
  total = 0;
  do {
    print('do-while total: ${total}');
    total += 1;
  } while (total < 11);

  // break문 사용해서 while 강제 종료하기
  total = 0;
  while(total < 11) {
    total ++;
    if (total % 3 == 0) {
      print('total이 3의 배수가 되었습니다. 반복문을 종료 합니다.');
      break;
    }
  }
  print(total); // 3출력
}