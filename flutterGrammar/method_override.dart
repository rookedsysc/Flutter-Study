void main() {
  TimesTwo tt = TimesTwo(2); 

  print(tt.calculate());

  TimesFour tf = TimesFour(2);

  print(tf.calculate());
}

// method - function (class 내부에 있는 함수)
// override - 덮어쓰다 (우선시하다))
class TimesTwo {
    final int number;

    TimesTwo (
        this.number, 
    );
    
    // method
    int calculate() {
        return number * 2; 
    }
}

class TimesFour extends TimesTwo {
  TimesFour (
    int number,
  ): super(number); 

  // 같은 시그니처의 함수르 작성하면 현재 클래스에서 override(덮어쓰기)할 수 있음
  /* @override 
  int calculate(){
    return super.number * 4; // this.number 또는 number로 써도 무방함
  } */
 
  @override 
  int calculate() {
    return super.calculate() * 4;
  }
}