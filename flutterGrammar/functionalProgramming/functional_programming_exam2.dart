void main() {
  List<Map<String, String>> people = [
    {
      "name" : "로제",
      "group" : "블랙핑크",
    },
    {
      "name" : "지수",
      "group" : "블랙핑크",
    },
    {
      "name" : "RM",
      "group" : "BTS",
    },
    {
      "name" : "뷔",
      "group" : "BTS",
    },
  ];

  print(people);

  final parsedPeople = people.map((x) => Person(
    name: x['name']!, // 값이 반드시 존재한다는 뜻. ! 안붙여주면 참조 error 발생함.
    group: x['group']!,
  )).toList();

  print(parsedPeople); 

  for(Person person in parsedPeople) {
    print(person.name);
    print(person.group);
  };

  final bts = parsedPeople.where(
    (x) => x.group == "BTS",
  );
}

class Person {
  final String name;
  final String group;

  Person({
    required this.name, 
    required this.group,
  });
  
  // class의 초기 값들은 Instance of 라는 형식으로 저장이 됨.
  // print를 했을 때 어떤 형식을 취하는지 object class에 String으로 정의되어 있는데 이를 바꿔줌으로서 출력형태를 바꿔줌.
  @override
  String toString(){
    return 'Person(name: $name, group: $group';
  }

}