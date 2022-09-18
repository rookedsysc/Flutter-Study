void main() {
  Employee seulgi = Employee('슬기');
  Employee chorong = Employee('초롱'); 

  // 각각 다른 인스턴스에 name 값을 다르게 넣어줬으므로 아래 출력문이 다르게 출력됨.
  seulgi.printnameAndBuilding(); // 제 이름은 슬기 입니다. null에서 근무하고 있습니다.
  chorong.printnameAndBuilding(); // 제 이름은 초롱 입니다. null에서 근무하고 있습니다.

  // 각각 다른 인스턴스라도 static으로 선언한 building의 값은 class에 귀속되므로 둘 다 'Naver'라는 값이 들어가 있음.
  Employee.building = 'Naver'; 
  seulgi.printnameAndBuilding(); // 제 이름은 슬기 입니다. Naver에서 근무하고 있습니다.
  chorong.printnameAndBuilding(); // 제 이름은 초롱 입니다. Naver에서 근무하고 있습니다.

  // static으로 정의된 method는 class의 이름에 바로 뒤에 method명을 붙여서 사용 가능.
  Employee.printBuilding();
}

class Employee {
  // static은 instance에 귀속되지 않고 class에 귀속됨.
  static String? building; // 알바생이 일하고 있는 건물
  final String name; // 알바생 이름

  Employee( 
    this.name,
  );
  void printnameAndBuilding() {
    print('제 이름은 ${name} 입니다. ${building}에서 근무하고 있습니다.');
  }

  static void printBuilding() {
    print('저희는 $building 건물에서 근무 중 입니다.');
  }
}