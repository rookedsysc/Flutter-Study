void main() {
  // List<generic>
  List<String> blackPink = ["제니", "지수", "로제", "리사"];
  List<int> numbers = [1, 2, 3, 4];

  print(blackPink);
  print(numbers);

  print(blackPink.length); // 배열의 길이

  // 리스트에 값 추가
  blackPink[3] = "아이유";
  print(blackPink);
  blackPink.add("수지");
  print(blackPink);

  // 리스트에 값 삭제
  blackPink.remove(4);
  blackPink.remove('아이유'); 
  print(blackPink);

  print(blackPink.indexOf("로제")); // 로제의 위치(index number) 찾기
}