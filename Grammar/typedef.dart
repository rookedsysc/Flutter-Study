void main() {
  Operation operation = add;
  int result = operation(10, 20, 30);
  operation = substact;
  int result2 = operation(30, 20, 5);

  print('add result: ${result}');
  print('subtract result: ${result2}');

  /* Operation 타입의 함수를 넣어줌
  여기선 add 함수가 들어갔고 해당 함수 내에서 reutrn operation 즉, add 함수의 결과값을 return 해주게 됨 */
  int result3 = calculate(3, 4, 5, add);
  print('typedef function result(add): ${result3}');
}

// signature: return 타입과 parameter의 형태를 signature라고 함
typedef Operation = int Function(int x, int y, int z);

// 더하기
int add (int x, int y, int z) => x + y + z;

// 빼기
int substact (int x, int y, int z) => x - y - z;

int calculate(int x, int y, int z, Operation operation) {
  return operation(x, y, z);
}