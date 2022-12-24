import 'dart:convert';

import 'package:lv2_actual/common/const/data.dart';

class DataUtils {
  // 반드시 static으로 선언해줘야 JsonKey에
  static pathToUrl(String thumbUrl) {
    return 'http://$ip/$thumbUrl';
  }
  
  static List<String> listsPathsToUrls(List thumbUrl) {
    return thumbUrl.map((e) => 'http://$ip/$e').toList();
  }

  static String plainToBase64(String plain) {
    // 어떻게 인코딩 할건지 정의
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // 정의를 이용해서 rawString을 인코딩
    String encoded = stringToBase64.encode(plain);

    return encoded;
  }
}
