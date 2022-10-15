import 'package:dust_today/const/status_level.dart';
import 'package:dust_today/model/stat_model.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import '../model/status_model.dart';

class DataUtils {
  static String getTimeFromDateTime({required DateTime dateTime}) {
    return DateFormat('yyyy-MM-dd hh:mm').format(dateTime).toString();
  }

  // itemCode > 단위
  static String getUnitFromItemCode({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10 :
        return '㎍/㎥';

      case ItemCode.PM25 :
        return '㎍/㎥';

      default :
        return 'ppm';
    }
  }

  // itemCode > 한글 번역
  static String itemCodeKrString({
    required ItemCode itemCode,
  }) {
    switch(itemCode) {
      case ItemCode.PM10:
        return '미세먼지';

      case ItemCode.PM25:
        return '초미세먼지';

      case ItemCode.O3:
        return '오존';

      case ItemCode.CO:
        return '일산화탄소';

      default :
        return '아황산가스';
    }
  }

  // itemCode에 따라서 비교를 해줌
  static StatusModel getStatusFromItemCodeAndValue({
    required double value,
    required ItemCode itemCode,
  }) {
    return statusLevel.where((status) {
      if(itemCode == ItemCode.PM10) {
        return status.minFineDust < value;
      } else if(itemCode == ItemCode.PM25) {
        return status.minUltraFineDust < value;
      } else if (itemCode == ItemCode.CO) {
        return status.minCO < value;
      } else if (itemCode == ItemCode.O3) {
        return status.minO3 < value;
      } else if (itemCode == ItemCode.NO2) {
        return status.minNO2 < value;
      } else {
        throw('알 수 없는 코드 입니다.');
      }
    }).last;
  }



}