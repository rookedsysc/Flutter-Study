void main() {
  List<int> even = [
    2, 4, 6, 8,
  ];

  List<int> odd = [
    1, 3, 5, 7, 9, 
  ];
  
  print([even, odd]); // 두 개의 list가 한 list안에 들어가 있음
  // cascading operator
  // ...
  print([...even, ...odd]); // 두 개의 list가 한 개의 list로 합쳐짐
}