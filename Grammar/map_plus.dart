void main(){
    final number = 123;

    print(number.toString().split('').map((e) => '$e.jpeg'));

    List<String> results = [];
    final numbers = [
      123,
      456,
      789
    ];

    // 내가 해결한 방법.
    // 출력값 : [1.jpeg, 2.jpeg, 3.jpeg, 4.jpeg, 5.jpeg, 6.jpeg, 7.jpeg, 8.jpeg, 9.jpeg]
    // 1차원 List로 해결함.
    for(int cnt = 0; cnt < numbers.length ; cnt++) {
      results += ((numbers[cnt].toString().split('').map((e) => '$e.jpeg')).map((e) => e)).toList();

      print(results);
    }

    results = [];

    // 강의에서 설명한 방법.
    // 출력값 : [[1.jpeg, 2.jpeg, 3.jpeg], [4.jpeg, 5.jpeg, 6.jpeg], [7.jpeg, 8.jpeg, 9.jpeg]]
    print(numbers.map(
      (e) => e.toString().split('').map(
        (y) => '$y.jpeg',
      ).toList(),
    ).toList());

	// 출력값 : what is entry? : (MapEntry(0: 123), MapEntry(1: 456), MapEntry(2: 789))
    print('what is entry? : ${numbers.asMap().entries}');

}
