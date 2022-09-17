// 프로그램이 실행되면 가장 먼저 실행되는 함수
// void는 return type, 즉, void는 return 값이 없음을 뜻함. 
void main() {
  addNumbers(10, 90, 100); // 기본값 무시하고 90, 100 들어감
  addNumbers(3);

  namedParameterNumbers(x: 3, y: 10, z: 20);
  namedOptionalParameter(x: 10);

  print('add result: ${addResult(x: 3, y: 10)}');
  print('arrow function result: ${arrowAdd(3, 5, 10)}');
}

// 세개의 숫자(x, y, z)를 더하고 짝수인지 홀수인지 알려주는 함수
// parameter / argument - 매개변수
// positional parameter - 순서가 중요한 파라미터

/* optional parameter - 있어도 되고 없어도 되는 파라미터 
[]를 통해서 파라미터를 지정해줘야 하며, null이 들어갈 수도 있기 때문에 기본값을 설정해줘야 함 */
addNumbers(int x, [int y = 20, int z = 30]) {
  int sum = x + y + z;

  print('x: $x');
  print('y: $y');
  print('z: $z');

  if ( sum % 2 == 0 ) {
    print('짝수 입니다.');
  } else {
    print("홀수 입니다.");
  }
}

// named parameter - 이름이 있는 파라미터 (순서가 중요하지 않음.)
namedParameterNumbers({
  required int x, 
  required int y,
  required int z, 
}) {
  int sum = x + y + z;

  print('named x: $x');
  print('named y: $y');
  print('named z: $z');

  if ( sum % 2 == 0 ) {
    print('짝수 입니다.');
  } else {
    print("홀수 입니다.");
  }
}

// named parameter를 optional로 설정해주게 되면 required를 지워줘야 함.
namedOptionalParameter ({
  required int x, 
  int y = 30, int z = 20
}) {
  int sum = x + y + z;

  print('namedOptionalParameter x: $x');
  print('namedOptionalParameter y: $y');
  print('namedOptionalParameter z: $z');
}

int addResult ({
  required int x, 
  required int y,
}) {
  int sum = x + y;

  return sum; 
}

// arrow 함수
int arrowAdd(int x, int y, int z) => x + y + z;