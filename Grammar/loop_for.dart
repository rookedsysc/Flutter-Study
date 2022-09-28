void main() {
  // for ( 시작; 조건; 실행구문 )
  for (int i = 0; i < 11; i++) {
    print('$i 번째 loop');
  }

  int total = 0;
  int backupNumber = 0;
  List<int> numbers = [1, 2, 3, 4, 5, 6];

  for (int i = 0; i < numbers.length ; i++) {    
    backupNumber = total;
    total += numbers[i];
    print('${numbers[i]} + ${backupNumber} == ${total}');
  }


  // for ( 자료형 in 순환가능한 자료형 ) 
  total = 0;
  backupNumber = 0;
  for (int number in numbers) {
    backupNumber = total;
    total += number;
    print('${number} + ${backupNumber} == ${total}');
  }

  // for문에서 continue 사용해보기 
  for (int i = 0; i < 11; i++ ){
    if (i == 5) {
      continue; // 반복문 다시 실행시킴 (5출력 x)
    }
    print(i);
  }
}