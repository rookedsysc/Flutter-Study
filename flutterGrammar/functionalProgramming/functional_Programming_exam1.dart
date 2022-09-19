void main() {
  String number = '12345';
  final numberJPEG = number.split('').map((x) => '$x.jpeg').toList();
  print(numberJPEG);
  example2();
  example3();
}

// Map > Map use map 
void example2() {
  Map<String, String> harryPoter = {
    "Harry Potter" : "해리 포터",
    "Ron Weasley" : "론 위즐리", 
    "Hermione Granger" : "헤르미온느 그레인저"
  };

  // map > map // Map Entry는 class 임. MapEntry(key, value)순으로 되어 있으며 key와 value에 각각 접근해서 return 해줌.
  final result = harryPoter.map((key, value) => MapEntry(
    'Harry Poter Character $key',
    '해리포터 캐릭터 $value',
    ),
  );
  print(result);

  final keys = harryPoter.keys.map((x) => 'HPC $x').toList;
  print(keys);
}

void example3() {
  Set blackPinkSet = {
    '로제', '지수', '제니', '리사',
  };

  final newSet = blackPinkSet.map((x) => '블랙핑크 $x');

  print(newSet);
}