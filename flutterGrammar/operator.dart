void main() { 
  double? number = 4.0;
  number ??= 3.0; // 변수가 null이면 오른쪽 값을 넣어주라는 뜻
  print(number); // 3 출력
  
  number = null;
  number ??= 2.0; 
  print(number); // 2출력

  int number2 = 30;; 
  print(number2 is int); // true 출력
  print(number2 is! int); // false 출력
  print(number2 is! String); // true 출력

  booleanOperator();
}

void booleanOperator() {
  bool result =  10 > 12;
  print(result); // false 출력
}