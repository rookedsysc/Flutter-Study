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

  // where((x) => 조건); 조건이 true인 값만 return 해줌
  final blackPink = people.where((x) => x["group"] == '블랙핑크');
  final bts = people.where((x) => x["group"] == 'BTS');
  print(bts);
  print(blackPink);
}