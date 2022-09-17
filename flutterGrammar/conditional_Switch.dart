void main(List<String> args) {
  // switch문
  int number = 158;

  switch(number % 3) {
    case 0:
    print('3의 배수 입니다.');
    break; //  break 반드시 넣어줘야 함 (C++)이랑 똑같음
    case 1:
    print('나머지가 1입니다.');
    break;
    default:
    print('나머지가 2입니다.'); 
    break;  
  }
}
  
