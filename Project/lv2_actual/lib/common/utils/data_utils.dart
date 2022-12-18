import 'package:lv2_actual/common/const/data.dart';

class DataUtils {
  // 반드시 static으로 선언해줘야 JsonKey에
  static pathToUrl(String thumbUrl) {
    return 'http://$ip/$thumbUrl';
  }
  
  static List<String> listsPathsToUrls(List thumbUrl) {
    return thumbUrl.map((e) => 'http://$ip/$e').toList();
  }
}