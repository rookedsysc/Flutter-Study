void main() {
  final parent = Parent(id: 1);
  print(parent.id);

  final child = Child(id: 2);
  print(child.id);

  final parent2 = Parent.fromInt(5);
  print(parent2);
}

class Parent{ 
  final int id;

  Parent({required this.id});
  // 현재 클래스의 인스턴스 뿐만이 아니라 현재 클래스를 상속하는 클래스를 인스턴스화 해서 반환할 수 있음
  factory Parent.fromInt(int id) => Child(id: id);
}

class Child extends Parent{
  Child({required super.id});
}