
void main() {
  DateTime now = DateTime.now();

  print(now);
  print(now.year);
  print(now.month);
  print(now.day);
  print(now.hour);
  print(now.second);
  print(now.minute);
  print(now.microsecond);

  Duration duration = Duration(seconds: 60);
  print(duration);
  print(duration.inDays);
  print(duration.inHours);
  print(duration.inMinutes);
  print(duration.inSeconds);

  DateTime specificDay = DateTime( // 년, 월, 일, 시, 분, 초, 밀
    2017, // 년
    11, // 월
    23, // 일
  );

  print(specificDay);

  // differenc와 specificDay 사이의 간격을 구해줌.
  final difference = now.difference(specificDay);
  print(difference);
  print(difference.inDays);
  print(difference.inHours); 
  print(difference.inMinutes);

  print(now.isAfter(specificDay)); // isAfter(날짜)가 현재 이전에 오는지, true 출력
  print(now.isBefore(specificDay)); // isBefore(날짜)가 현재 이후에 오는지, false 출력

  print('--------------------');
  print(now);
  print(now.add(Duration(hours: 10))); // 시간 덧셈
  print(now.subtract(Duration(hours: 5))); // 시간 뺄셈
}