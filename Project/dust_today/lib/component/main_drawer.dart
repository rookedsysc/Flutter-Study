import 'package:dust_today/const/color.dart';
import 'package:flutter/material.dart';

import '../const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;
  const MainDrawer ({
    required this.selectedRegion,
    required this.onRegionTap,
    super.key});

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
                // e에는 region이 들어감
                (e) => ListTile(
                  tileColor: Colors.white, // 타일 색상
                  selectedTileColor: lightColor, // 선택된 타일 색상
                  selectedColor: Colors.black, // 선택 했을 때 색상
                  selected: e == selectedRegion,
                  onTap: (){
                    onRegionTap(e);
                  },
                  title: Text(e),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}