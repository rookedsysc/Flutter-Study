import 'package:dust_today/component/main_app_bar.dart';
import 'package:dust_today/component/main_drawer.dart';
import 'package:dust_today/component/main_stat.dart';
import 'package:dust_today/const/color.dart';
import 'package:dust_today/const/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold 안에 넣어주기만 하면 자동으로 넣어줌
      drawer: MainDrawer(),
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.0),
                  shape: RoundedRectangleBorder( // Card의 테두리를 둥글게 해줌
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  color: lightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: darkColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '종류별 통계',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MainStat(
                              category: '미세먼지',
                              level: '최고',
                              imgPath: 'asset/img/best.png',
                              stat: '0㎍/㎥'),
                          MainStat(
                              category: '미세먼지',
                              level: '최고',
                              imgPath: 'asset/img/best.png',
                              stat: '0㎍/㎥'),
                          MainStat(
                              category: '미세먼지',
                              level: '최고',
                              imgPath: 'asset/img/best.png',
                              stat: '0㎍/㎥'),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
          

        ],
      ),
    );
  }
}
