import 'package:dust_today/const/color.dart';
import 'package:flutter/material.dart';

const regions = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '경남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          // Collection 형태의 ListTile을 Spread Oprator를 활용해서 넣어줌   
          ...regions 
              .map(
                (e) => ListTile(
                  tileColor: Colors.white, // 타일 색상
                  selectedTileColor: lightColor, // 선택된 타일 색상
                  selectedColor: Colors.black, // 선택 했을 때 색상
                  selected: e == '서울',
                  onTap: () {},
                  title: Text(e),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}