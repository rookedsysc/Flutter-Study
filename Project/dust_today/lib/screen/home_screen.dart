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
import 'package:dust_today/const/regions.dart';
import 'package:dust_today/const/status_level.dart';
import 'package:dust_today/model/stat_and_status_model.dart';
import 'package:dust_today/model/stat_model.dart';
import 'package:dust_today/repository/stat_repository.dart';
import 'package:dust_today/utils/data_utils.dart';
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
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();

    scrollController.addListener(scrollListener);
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    super.dispose();
  }


  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData( // json 데이터
          itemCode: itemCode,
        ),
      );
    }
    // futures에 들어있는 모든 Future이 실행될 때까지 기다림
    // 해당 Future 실행결과 값, 즉, List<StatModel>이 들어감
    final results = await Future.wait(futures);

    for (int i = 0; i < futures.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({
        key: value,
      });
    }

    return stats;
  }

  // isExpanded 값을 여기서 결정
  scrollListener() {
    // 보이는 값 말고 실제 최상단에서 부터 현재 스크롤하는 위치까지의 간격
    // 500을 넘어가면 닫혀있는 상태
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if(isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          // 에러가 있을 때
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('에러가 있습니다!'),
              ),
            );
          }

          // 로딩 상태
          if (!snapshot.hasData) {
            // 에러가 있을 때 Scaffold가 없을 수도 있으므로
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          // 현재 값의 status Level 구하기
          // 대표적으로 보여줄 데이터를 pm10으로 특정해줌.
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];
          final status = DataUtils.getStatusFromItemCodeAndValue(
              value: pm10RecentStat.seoul,
              itemCode: ItemCode.PM10
          );


          // itemCode별로
          final ssModel = stats.keys.map((key) { // key means itemCode
            final value = stats[key]!; // json Data
            final stat = value[0]; // 가장 최근 데이터

            return StatAndStatusModel(itemCode: key,
                stat: stat,
                status: DataUtils.getStatusFromItemCodeAndValue(
                    value: stat.getLevelFromRegion(region), itemCode: key));
          }).toList();

          return Scaffold(
            // Scaffold 안에 넣어주기만 하면 자동으로 넣어줌
            // 왼쪽에서 bottomSheet나 snackBar처럼 화면을 덮으면서 나오는 화면
              drawer: MainDrawer(
                darkColor: status.darkColor,
                lightColor: status.lightColor,
                selectedRegion: region,
                onRegionTap: ((e) {
                  setState(() {
                    // main_drawer에서 넘겨준 e(region)이 region에 담김.
                    // region은 selectedRegion에 들어가서 선택된 도시를 바꿔줌.
                    region = e;
                  });
                  Navigator.of(context).pop();
                }),
              ),

              body:Container(
                color: status.primaryColor, // scaffold에서 지정 안하고 여기서 배경색 지정함.
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    MainAppBar(
                      region: region,
                      stat: pm10RecentStat,
                      status: status,
                      dateTime: pm10RecentStat.dataTime,
                      isExpanded: isExpanded,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CategoryCard(models: ssModel, region: region, darkColor: status.darkColor, lightColor: status.lightColor,
                          ),
                          const SizedBox(height: 16.0,),
                          ...stats.keys.map((itemCode)  {
                            final stat = stats[itemCode]!;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HourlyCard(
                                darkColor: status.darkColor,
                                lighColor: status.lightColor,
                                region: region,
                                stats: stat,
                                category: DataUtils.getItemCodeKrString(
                                    itemCode: itemCode),
                              ),
                            );
                          }).toList(),
                          SizedBox(height: 8.0,)
                        ],
                      ),
                    )
                  ],
                ),
              )
          );

        }
    );
  }
}
