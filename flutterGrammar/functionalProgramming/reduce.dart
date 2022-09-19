void main() {
  List<int> numbers = [
      1, 2, 3, 4, 5, 6, 7, 8, 9,
  ];

  // 배열의 끝까지 loop 발생, 첫 번째는 prev + next 해주고 그 이후로는 total + next 해줌.
  final result = numbers.reduce((prev, next){
    print('-------------------');
    print('prev : $prev');
    print('next : $next');
    print('total : ${prev + next}');

    return prev + next;
  });

  final result2 = numbers.reduce((prev, next) => prev + next);

  print('result : $result');
  print('result2 : $result2');

  List<String> words = [
    '안녕하세요. ',
    '저는 ', 
    'rookedsysc 입니다.',
  ];

  final sentence = words.reduce((prev, next) => prev + next);
  print(sentence);

  // reduce 사용시 parameter의 data tyep과 return result의 data type이 같아야 함
  final totalLength = words.reduce((prev, next) => (prev.length + next.length).toString());
  print('sentence\'s length : $totalLength');

  foldExam();
}

void foldExam() {
  List<int> nubmers = [1, 3, 5, 7 ,9];

  final sum = nubmers.fold<int>(0, (prev, next) => prev + next);
  print(sum); 
}