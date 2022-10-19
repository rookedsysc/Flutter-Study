import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/model/status_model.dart';

// category card에 넣을 model(데이터)
class StatAndStatusModel {
  StatAndStatusModel({
    required this.itemCode,
    required this.stat,
    required this.status,
  });
  // 미세먼지 / 초미세먼지
  final ItemCode itemCode;
  final StatusModel status;
  final StatModel stat;
}