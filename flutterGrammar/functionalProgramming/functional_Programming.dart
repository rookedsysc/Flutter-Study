void main() {
  List<String> blackPink = ['로제', '지수', '리사', '제니', '지수'];

  print('Black Pink : ${blackPink}');
  print('List to Map : ${blackPink.asMap()}'); // List > Map 
  print('List to Set : ${blackPink.toSet()}'); // List > Set

  Map blackPinkMap = blackPink.asMap(); // List > Map 저장

  print('blakcPinkMap Keys : ${blackPinkMap.keys}'); 
  print('blakcPinkMap Values : ${blackPinkMap.values}');
  print('Map To List : ${blackPinkMap.values.toList()}'); // Map > List

  Set blackPinkSet = Set.from(blackPink); // List > Set 저장

  print(blackPinkSet.toList()); // Set > List 

  // map()은 파라미터로 함수를 넣어줌
  // 첫 번째 파라미터는 List의 멤버를 모두 받게 됨
  final newBlackPink = blackPink.map((x){
    return '블랙핑크 $x'; // 멤버들의 값이 블랙핑크 OO으로 변경됨
  }); 

  // arrow 함수 사용, .map(parameter) => [return result]; 
  final newBlackPink2 = blackPink.map((x) => '블랙핑크 $x');
  print('BlackPink : $blackPink');
  print('newBlackPink : $newBlackPink');
}