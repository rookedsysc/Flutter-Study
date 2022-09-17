void main() {
  print('Hello Code Factory'); // 세미콜론 필요함
  
  // variable, 타입 유추
  var name = "독거노인";
  print(name);
  name = "플러터 프로그래밍";
  print(name); 
  
  // integer
  int number1 = 10;
  int number2 = 15;
  print(number1);  
  print(number1 + number2); 
  
  // double 
  double doubNum1 = 2.5;
  double doubNum2 = 0.5;
  print(doubNum1 + doubNum2); // 3 출력
  
  // Boolean
  bool isTrue = true;
  bool isFalse = false; 
  
  // String, 대문자로 선언
  String name1 = "아이유";
  print(name.runtimeType); // 실행시에 동작하는 타입, String 출력
  print(name + ' ' + name1);
  print('${name}'); 
  print('$name'); 
  print('${name.runtimeType}');
  // print("$name.runtimeType"); // Error Alert
  
  // var type과 비슷함
  dynamic dynamicName = "코드팩토리";
  dynamic dynamicNumber = 1;
  print(name.runtimeType); 
  // var와는 다르게 다른 type의 값도 넣을 수 있음
  dynamicName = 3;
  dynamicNumber = "코드 팩토리"; 
  
  // nullable - null이 될 수 있다.
  // non-nullable - null이 될 수 없다.
  // null - 아무런 값도 있지 않다.
  
  String stringName = "독거노인";
  // name = null // Error 발생
  
  String? name2 = "블랙핑크";
  name2 = null; 
  print(name2);  
  name2 = null;
}