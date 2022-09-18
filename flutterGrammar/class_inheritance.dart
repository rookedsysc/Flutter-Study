void main() {
  print('----- Idol -----');
  Idol apink = Idol(name: "Apink", membersCount: 5);
  apink.sayName();
  apink.sayMembersCount();

  print('----- BoyGroup -----');
  BoyGroup bts = BoyGroup('bts', 7);
  bts.sayName();
  bts.sayMembersCount();
  bts.sayMale(); // apink에서는 없음

  print('---- GirlGroup ----');
  GirlGroup redVelvet = GirlGroup('redVelvet', 5);
  redVelvet.sayName();
  redVelvet.sayMembersCount();
  redVelvet.sayFemale(); // bts, apink는 사용불가

  print('---- Type Comparison ----');
  print(redVelvet is Idol); // true
  print(redVelvet is GirlGroup); // true
}

// 상속 - inheritance
// 상속을 받으면 부모 클래스의 모든 속성을 자식 클래스가 부여받음.
class Idol {
  String name;
  int membersCount; 

  Idol({ // Named Parameter
    required this.name, 
    required this.membersCount, 
  });

  void sayName(){
    print('저는 ${this.name} 입니다.');
  }

  void sayMembersCount() {
    print('${this.name}은 ${this.membersCount}명의 멤버가 있습니다.');
  }
}

class BoyGroup extends Idol { // extends로 부모 클래스를 상속받음.
  BoyGroup(
    String name, 
    int membersCount,
  ): super( // 부모 클래스의 Named Parameter
    name: name,
    membersCount: membersCount
  ); 
  void sayMale() {
    print('저는 남자 아이돌 입니다.');
  }
}

class GirlGroup extends Idol {
  GirlGroup(
    String name,
    int membersCount, 
  ): super(
    name: name,
    membersCount: membersCount,
  );

  void sayFemale() {
    print('저는 여자 아이돌 입니다.');
  }
}