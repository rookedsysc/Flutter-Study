import 'package:flutter_riverpod/flutter_riverpod.dart';

// 생성하는 순간에 어떤 변수를 입력을 해줘서 이 변수로 프로바이더 안의 로직을 변경해야 할 때 사용
final familyModifierProvider = FutureProvider.family<List<int>, int>(
  (ref, data) async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(5, (index) => data * index).toList();
  },
);
