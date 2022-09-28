void main() {
  Idol blackPink = Idol( // const를 사용할 때는 값을 선언하는 부분에도 const로 변수를 만들어줘야 함
    "블랙핑크",
    ['제니', '지수', '리사', '로제'],
  );
  Idol blackPink2 = Idol(
    "블랙핑크",
    ['제니', '지수', '리사', '로제'],
  );
  Idol bigBang = const Idol (
    "빅뱅", 
    ['GD', 'TOP', '대성', '태양', '패배'],
  );
  Idol bigBang2 = const Idol (
    "빅뱅", 
    ['GD', 'TOP', '대성', '태양', '패배'],
  );
  print(blackPink == blackPink2); // false 출력
  print(bigBang == bigBang2); // true 출력 (const로 선언한 class는 값을 비교하면 같다고 return해줌)
}

class Idol {
  final String name;
  final List<String> members;

  void sayHello() {
    print("안녕하세요. ${this.name} 입니다.");
  }
  void introduce() {
    print('저희 멤버는 ${this.members}가 있습니다.');
  }  
  // imutable 프로그래밍 : 선언한 이후에 값을 변경할 수 없도록 해줌.
  const Idol(this.name, this.members); 
}