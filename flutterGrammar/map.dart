void main() {
  // Map  ( Key / Value)
  Map<String, String> dictionary = {
    // Key / Value
    "Harry Potter": "해리포터", 
    "Ron Weasley":"론 위즐리", 
    "Hermione Granger": "헤르미온느 그레인저",
  };

  print(dictionary);

  Map<String, bool> isHarryPotter = {
    "Harry Potter": true, 
    "Ron Weasley": true, 
    "Hermione Granger": true,
    'Ironman': false
  }; 

  print(isHarryPotter);
  
  // Map에 요소 추가
  isHarryPotter.addAll({
    "Spiderman": false
  }); 
  isHarryPotter["Hulk"] = false; 

  print(isHarryPotter);

  isHarryPotter.remove("Harry Potter");
  print(isHarryPotter);

  // 배열 요소에 접근
  // key 값으로 접근하면 value 값 return 
  print(isHarryPotter["Ironman"]); // false 출력
  print(isHarryPotter.keys); // 전체 key 값 출력
  print(isHarryPotter.values); 
}