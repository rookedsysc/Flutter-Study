import 'package:dio/dio.dart';
import 'package:dust_today/component/card_title.dart';
import 'package:dust_today/component/category_card.dart';
import 'package:dust_today/component/hourly_card.dart';
import 'package:dust_today/component/main_app_bar.dart';
import 'package:dust_today/component/main_card.dart';
import 'package:dust_today/component/main_drawer.dart';
import 'package:dust_today/component/main_stat.dart';
import 'package:dust_today/const/color.dart';
import 'package:dust_today/const/custom_font.dart';
import 'package:dust_today/const/status_level.dart';
import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/repository/stat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dust_today/const/data.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();

    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold 안에 넣어주기만 하면 자동으로 넣어줌
      drawer: MainDrawer(),
      backgroundColor: primaryColor,
      body: FutureBuilder<List<StatModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            // 에러가 있을 때
            if (snapshot.hasError) {
              return Center(
                child: Text('에러가 있습니다!'),
              );
            }

            // 로딩 상태
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<StatModel> stats = snapshot.data!;

            // 현재 값의 status Level 구하기
            StatModel recentStat = stats[0];
            final status = statusLevel
                // minFineDust가 현재 서울의 농도보다 작은 것들만 필터링
                .where((element) => element.minFineDust < recentStat.seoul)
                .last; // 그 중에서 마지막(가장 높은 값)

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  stat: recentStat,
                  status: status,
                ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CategoryCard(),
                    const SizedBox(height: 16.0,),
                    HourlyCard(),
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
