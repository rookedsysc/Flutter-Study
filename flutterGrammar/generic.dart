void main() {
  Lecture<String> lecture1 = Lecture('123', 'lecture1');
  lecture1.printIdType(); // String 출력

  Lecture<int> lecture2 = Lecture(123, 'lecture2');
  lecture2.printIdType();

  Teacher<String, int> classRoom = Teacher('아이유', 1);
  classRoom.printTeachingMe();
}

// generic - 타입을 외부에서 받을 때 사용
// 외부에서 타입을 추론해서 값을 받을 때 사용
class Lecture<typeName> {
  final typeName id;
  final String name;

  Lecture(this.id, this.name);

  void printIdType() {
    print(id.runtimeType);
  }
}

class Teacher<x, y> {
  final x teacher;
  final y subject;

  Teacher(this.teacher, this.subject); 

  void printTeachingMe() {
    print('$teacher 선생님은 $subject 과목을 가르치십니다.');
  }
}