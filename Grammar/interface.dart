import 'class_inheritance.dart';

void main() {
  BoyGroup bts = BoyGroup('BTS');
  GirlGroup redVelvet = GirlGroup('레드벨벳');
  // IdolInterface blackPink = IdolInterface('블랙핑크'); 에러 발생함

  bts.sayName();
  redVelvet.sayName();

  // 상속이랑 똑같음.
  print(bts is IdolInterface); // true
  print(bts is BoyGroup); // true
}

// 어떤 특수한 구조를 강제할 때 사용함.
// abstarct를 앞에 붙이면 해당 Interface를 통해서 인스턴스를 생성할 수 없음.
abstract class IdolInterface {
  String name;

  IdolInterface(this.name);
   
  // 다른 class를 만들 때 이 형태를 지키게 강제하기 위해서 선언함
  void sayName();
}

// Interface를 사용할 땐 implements를 사용함.
class BoyGroup implements IdolInterface {
  String name;

  BoyGroup(this.name); 

  void sayName() {
    print('제 이름은 $name 입니다.');
  }
}

class GirlGroup implements IdolInterface {
  String name;

  GirlGroup(this.name);

  void sayName() {
    print('제 이름은 $name 입니다.');
  }
}