import 'package:hive_flutter/hive_flutter.dart';

part 'stat_model.g.dart';

@HiveType(typeId: 2)
enum ItemCode {
  // 미세 먼지
  @HiveField(0) // type 1번의 0번과는 다름
  PM10,
  // 초미세 먼지
  @HiveField(1)
  PM25,
  // 이산화 질소
  @HiveField(2)
  NO2,
  // 오존
  @HiveField(3)
  O3,
  // 일산화탄소
  @HiveField(4)
  CO,
  // 이황산가스
  @HiveField(5)
  SO2,
}

// Class는 Type이 구성되는 요소가 천차만별이기 때문에, Hive가 이 타입을 알 수 있게 해주는 방법임
@HiveType(typeId: 0) // type id 절대 중복되면 안됨
class StatModel {
  // class 안에서 사용할 속성들을 다 decoration 해줘야 함
  @HiveField(0) // type 안에서는 절대로 곂치면 안됨
  final double daegu;
  @HiveField(1)
  final double chungnam;
  @HiveField(2)
  final double incheon;
  @HiveField(3)
  final double daejeon;
  @HiveField(4)
  final double gyeongbuk;
  @HiveField(5)
  final double sejong;
  @HiveField(6)
  final double gwangju;
  @HiveField(7)
  final double jeonbuk;
  @HiveField(8)
  final double gangwon;
  @HiveField(9)
  final double ulsan;
  @HiveField(10)
  final double jeonnam;
  @HiveField(11)
  final double seoul;
  @HiveField(12)
  final double busan;
  @HiveField(13)
  final double jeju;
  @HiveField(14)
  final double chungbuk;
  @HiveField(15)
  final double gyeongnam;
  @HiveField(16)
  final double gyeonggi;
  @HiveField(17)
  final DateTime dataTime;
  @HiveField(18)
  final ItemCode itemCode;

  // 대부분의 Code Generator들은 기본 Constructor가 있어야 함
  StatModel({
    required this.daegu,
    required this.chungnam,
    required this.incheon,
    required this.daejeon,
    required this.gyeongbuk,
    required this.sejong,
    required this.gwangju,
    required this.jeonbuk,
    required this.gangwon,
    required this.ulsan,
    required this.jeonnam,
    required this.seoul,
    required this.busan,
    required this.jeju,
    required this.chungbuk,
    required this.gyeongnam,
    required this.gyeonggi,
    required this.dataTime,
    required this.itemCode,
  });


  // constructor를 JSON 형태에서부터 데이터를 받아옴
  // json { "key" : "valeu" } 형태
  StatModel.fromJson({required Map<String, dynamic> json})
      : daegu = double.parse(json['daegu'] ?? '0'), // null이 될 경우 0을 대신 보여줌
        chungnam = double.parse(json['chungnam'] ?? '0'),
        incheon = double.parse(json['incheon'] ?? '0'),
        daejeon = double.parse(json['daejeon'] ?? '0'),
        gyeongbuk = double.parse(json['gyeongbuk'] ?? '0'),
        sejong = double.parse(json['sejong'] ?? '0'),
        gwangju = double.parse(json['sejong'] ?? '0'),
        jeonbuk = double.parse(json['jeonbuk'] ?? '0'),
        gangwon = double.parse(json['gangwon'] ?? '0'),
        ulsan = double.parse(json['ulsan'] ?? '0'),
        jeonnam = double.parse(json['jeonnam'] ?? '0'),
        seoul = double.parse(json['seoul'] ?? '0'),
        busan = double.parse(json['busan'] ?? '0'),
        jeju = double.parse(json['jeju'] ?? '0'),
        chungbuk = double.parse(json['chungbuk'] ?? '0'),
        gyeongnam = double.parse(json['gyeongnam'] ?? '0'),
        gyeonggi = double.parse(json['gyeonggi'] ?? '0'),
        dataTime = DateTime.parse(json['dataTime']),
        itemCode = parseItemCode(json['itemCode']);

  static ItemCode parseItemCode(String raw) {
    if (raw == 'PM2.5') {
      return ItemCode.PM25;
    }
    return ItemCode.values.firstWhere((element) =>
        // ItemCode Enum의 Value가 raw(json의 원시 데이터)와 같다면 return 해줌.
        element.name == raw);
  }

  double getLevelFromRegion(String region) {
    if ('서울' == region) {
      return seoul;
    } else if ('경기' == region) {
      return gyeonggi;
    } else if ('대구' == region) {
      return daegu;
    } else if ('충남' == region) {
      return chungnam;
    } else if ('인천' == region) {
      return incheon;
    } else if ('대전' == region) {
      return daejeon;
    } else if ('경북' == region) {
      return gyeongbuk;
    } else if ('세종' == region) {
      return sejong;
    } else if ('광주' == region) {
      return gwangju;
    } else if ('전북' == region) {
      return jeonbuk;
    } else if ('강원' == region) {
      return gangwon;
    } else if ('울산' == region) {
      return ulsan;
    } else if ('전남' == region) {
      return jeonnam;
    } else if ('부산' == region) {
      return busan;
    } else if ('제주' == region) {
      return jeju;
    } else if ('충북' == region) {
      return chungbuk;
    } else if ('경남' == region) {
      return gyeongnam;
    } else { throw Exception('알 수 없는 지역 입니다.'); }
  }
}
