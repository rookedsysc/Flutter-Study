void main() {
  Idol blackPink = Idol( // const를 사용할 때는 값을 선언하는 부분에도 const로 변수를 만들어줘야 함
    "블랙핑크",
    ['제니', '지수', '리사', '로제'],
  );
  
  Idol bigBang = Idol (
    "빅뱅", 
    ['GD', 'TOP', '대성', '태양', '패배'],
  );
  print(bigBang.firstMemeber); // GD 출력
  bigBang.firstMemeber = 'G-Dragon';
  print(bigBang.firstMemeber); // G-Dragon 출력
}
// getter / setter
// 데이터를 가져올 때 / 데이터를 설정할 때
class Idol {
  final String name;
  final List<String> members;

  // imutable 프로그래밍 : 선언한 이후에 값을 변경할 수 없도록 해줌.
  const Idol(this.name, this.members); 

  void sayHello() {
    print("안녕하세요. ${this.name} 입니다.");
  }
  void introduce() {
    print('저희 멤버는 ${this.members}가 있습니다.');
  }  
  
  // gettter
  // returmType get getterName
  String get firstMemeber {
    return this.members[0];
  }

  // settter
  // set setterName(parameter) 
  //  parameter는 한 개만 들어갈 수 있음 setter에다가 값을 대입해서 넣어주기 때문
  set firstMemeber(String name) {
    this.members[0] = name;
  } 
 
}