import 'dart:async';

void main() {
  final reuslt = calculate(1);
  
}

Future<int?> calculate (int number) async {
  for (int i = 0; i < 5; i++) {
    print(i);

	  return i * number;
  }
}
