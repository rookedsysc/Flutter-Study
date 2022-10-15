/*
  * 1) 최고
  *
  * 미세먼지 : 0-15
  * 초미세먼지 : 0-8
  * 오존(O3) : 0-0.02
  * 이산화질소(NO2) : 0-0.02
  * 일산화탄소(CO) : 0-0.02
  * 아황산가스(SO2) : 0-0.01
  *
  * 2) 좋음
  *
  * 미세먼지 : 16-30
  * 초미세먼지 : 9-15
  * 오존 : 0.02 - 0.03
  * 이산화질소 : 0.02-0.03
  * 일산화탄소 : 1-2
  * 아황산가스 : 0.01-0.02
  *
  * 3) 양호
  *
  * 미세먼지 : 31-40
  * 초미세먼지 : 16-20
  * 오존 : 0.03-0.06
  * 이산화질소 : 0.03-0.05
  * 일산화탄소 : 2-5.5
  * 아황산가스 : 0.02-0.04
  *
  * 4) 보통
  *
  * 미세먼지 : 41-50
  * 초미세먼지 : 21-25
  * 오존 : 0.06-0.09
  * 이산화질소 : 0.05-0.06
  * 일산화탄소 : 5.5-9
  * 아황산가스 : 0.04-0.05
  *
  * 5) 나쁨
  *
  * 미세먼지 : 51-75
  * 초미세먼지 : 26-37
  * 오존 : 0.09-0.12
  * 이산화질소 : 0.06-0.13
  * 일산화탄소 : 9-12
  * 아황산가스 : 0.05-0.1
  *
  * 6) 상당히나쁨
  *
  * 미세먼지 : 76-100
  * 초미세먼지 : 38-50
  * 오존 : 0.12-0.15
  * 이산화질소 : 0.13-0.2
  * 일산화탄소 : 12-15
  * 아황산가스 : 0.1-0.15
  *
  * 7) 매우 나쁨
  *
  * 미세먼지 : 101-150
  * 초미세먼지 : 51-75
  * 오존 : 0.15-0.38
  * 이산화질소 : 0.2-1.1
  * 일산화탄소 : 15-32
  * 아황산가스 : 0.15-0.16
  *
  * 8) 최악
  *
  * 미세먼지 : 151~
  * 초미세먼지 : 76~
  * 오존 : 0.38~
  * 이산화질소 : 1.1~
  * 일산화탄소 : 32~
  * 아황산가스 : 0.16~
  * */

// 상태에 따라서 한 번에 UI상에 랜더링 해줄 수 있도록 해주기 위함.
import 'package:dust_today/model/status_model.dart';
import 'package:flutter/material.dart';

final statusLevel = [
  // 최고
  StatusModel(
      level: 0,
      label: '최고',
      primaryColor: Color(0xFF2196F3),
      darkColor: Color(0xFF0069C0),
      lightColor: Color(0xFF6EC6FF),
      detailFontColor: Colors.black,
      imagePath: 'asset/img/best.png',
      comment: '우와! 100년에 한 번 오는  날!',
      minFineDust: 0,
      minUltraFineDust: 0,
      minO3: 0,
      minNO2: 0,
      minCO: 0,
      minSO2: 0),
  // 좋음
  StatusModel(
    level: 1,
    label: '좋음',
    primaryColor: Color(0xFF03a9f4),
    darkColor: Color(0xFF007ac1),
    lightColor: Color(0xFF67daff),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/good.png',
    comment: '공기가 좋아요! 외부활동 해도 좋아요!',
    minFineDust: 16,
    minUltraFineDust: 9,
    minO3: 0.02,
    minNO2: 0.02,
    minCO: 1,
    minSO2: 0.01,
  ),
  // 양호
  StatusModel(
    level: 2,
    label: '양호',
    primaryColor: Color(0xFF00bcd4),
    darkColor: Color(0xff008ba3),
    lightColor: Color(0xff62efff),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/ok.png',
    comment: '공기가 좋은 날이에요!',
    minFineDust: 31,
    minUltraFineDust: 16,
    minO3: 0.03,
    minNO2: 0.03,
    minCO: 2,
    minSO2: 0.02,
  ),
  // 보통
  StatusModel(
    level: 3,
    label: '보통',
    primaryColor: Color(0xFF009688),
    darkColor: Color(0xFF00675b),
    lightColor: Color(0xff52c7b8),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/mediocre.png',
    comment: '나쁘지 않네요!',
    minFineDust: 41,
    minUltraFineDust: 21,
    minO3: 0.06,
    minNO2: 0.05,
    minCO: 5.5,
    minSO2: 0.04,
  ),
  // 나쁨
  StatusModel(
    level: 4,
    label: '나쁨',
    primaryColor: Color(0xffffc107),
    darkColor: Color(0xffc79100),
    lightColor: Color(0xfffff350),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/bad.png',
    comment: '공기가 안좋아요...',
    minFineDust: 51,
    minUltraFineDust: 26,
    minO3: 0.09,
    minNO2: 0.06,
    minCO: 9,
    minSO2: 0.05,
  ),
// 상당히 나쁨
  StatusModel(
    level: 5,
    label: '상당히 나쁨',
    primaryColor: Color(0xffff9800),
    darkColor: Color(0xffc66900),
    lightColor: Color(0xffffc947),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/very_bad.png',
    comment: '공기가 나빠요! 외부활동을 자제해주세요!',
    minFineDust: 76,
    minUltraFineDust: 38,
    minO3: 0.12,
    minNO2: 0.13,
    minCO: 12,
    minSO2: 0.1,
  ),
  // 매우 나쁨
  StatusModel(
    level: 6,
    label: '매우 나쁨',
    primaryColor: Color(0xfff44336),
    darkColor: Color(0xffba000d),
    lightColor: Color(0xffff7961),
    detailFontColor: Colors.black,
    imagePath: 'asset/img/worse.png',
    comment: '매우 안좋아요! 나가지 마세요!',
    minFineDust: 101,
    minUltraFineDust: 51,
    minO3: 0.15,
    minNO2: 0.2,
    minCO: 15,
    minSO2: 0.15,
  ),
  // 최악
  StatusModel(
    level: 7,
    label: '최악',
    primaryColor: Color(0xff212121),
    darkColor: Color(0xff000000),
    lightColor: Color(0xff484848),
    detailFontColor: Colors.white,
    imagePath: 'asset/img/worst.png',
    comment: '역대급 최악의 날! 집에만 계세요!',
    minFineDust: 151,
    minUltraFineDust: 76,
    minO3: 0.38,
    minNO2: 1.1,
    minCO: 32,
    minSO2: 0.16,
  ),
];
