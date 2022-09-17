void main(List<String> args) {
  int number = 2;
  // number = 0;

  if ( number == 0 ) {
    print("${number}은 짝수 입니까?");
  } else if( number % 2 == 0) {
    print('${number}는 짝수 입니다.'); 
  }  else {
    print('${number}는 홀수 입니다.');
  }
}