import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/data.dart';


class Utils {
  // 반드시 static으로 선언해야 함
  static pathToUrl(String thumbUrl) {
    return 'http://$ip/$thumbUrl';
  }

}


