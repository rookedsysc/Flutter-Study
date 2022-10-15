import 'package:dio/dio.dart';

import '../const/data.dart';
import '../model/stat_model.dart';

class StatRepository {
  // static 붙이면 () 안붙이고 .으로 불러올 수 있음.
  static Future<List<StatModel>> fetchData() async {
    final response = await Dio().get(
        'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
        queryParameters: {
          'serviceKey': serviceKey,
          'returnType': 'json',
          'numOfRows': 30,
          'pageNo': 1,
          'itemCode': 'PM10',
          'dataGubun': 'HOUR',
          'searchCondition': 'WEEK',
        });

    // 시간별 데이터가 List 형태로 들어가게 되고 fromJson에서 dart의 Map 형태로 출력됨
    return response.data['response']['body']['items'].map<StatModel>( 
      (item) => StatModel.fromJson(json: item),
    ).toList();
  }
}
