enum ItemCode {
  // 미세 먼지
  PM10,
  // 초미세 먼지
  PM25,
  // 이산화 질소
  NO2,
  // 오존
  O3,
  // 일산화탄소
  CO,
  // 이황산가스
  SO2,
}

class StatModel {
  final double daegu;
  final double chungnam;
  final double incheon;
  final double daejeon;
  final double gyeongbuk;
  final double sejong;
  final double gwangju;
  final double jeonbuk;
  final double gangwon;
  final double ulsan;
  final double jeonnam;
  final double seoul;
  final double busan;
  final double jeju;
  final double chungbuk;
  final double gyeongnam;
  final double gyeonggi;
  final DateTime dataTime;
  final ItemCode itemCode;

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
