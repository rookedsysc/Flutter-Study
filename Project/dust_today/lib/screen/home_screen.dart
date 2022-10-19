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
import 'package:hive_flutter/hive_flutter.dart';

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

    fetchData();
    scrollController.addListener(scrollListener);
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    super.dispose();
  }


  // 모든 itemCode별로
  Future<void> fetchData() async {
    final now = DateTime.now();
    final fetchTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final box = Hive.box(ItemCode.PM10.name);
    final recent = box.values.last as StatModel;

    // 최신 데이터의 날짜와 현재 시간의 날짜가 같으면 아래에서 실행하는 구문 실행하지 않음
    if(recent.dataTime.isAtSameMomentAs(fetchTime)) {
      print('이미 최신 데이터가 있습니다.');
      return;
    }

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
      
      // main에서 생성한 box 열기 
      final box = Hive.box<StatModel>(key.name);
      for(StatModel stat in value) {
        // key 값에 dataTime을 넣어줌으로써 데이터가 절대로 중복되지 않음
        box.put(stat.dataTime.toString(), stat);

        final allKeys = box.keys.toList();

        if(allKeys.length > 24) {
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24); // 마지막 24개 남기고 다 지움
          box.deleteAll(deleteKeys);
        }
      }
    }

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
    return ValueListenableBuilder(
        valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(), // 현재 status 값이 필요하기 때문에 PM10 값을 가져옴
        builder: (context, box, widget) {
          // box == PM10 (미세먼지)
          // box.values.toList().last // 미세먼지 데이터의 첫 번째 값(서울)
          // swift의 다운캐스팅과 유사함 .last 값이 StatModel이라는 것을 명시해줌
          final recentStat = box.values.toList().last as StatModel;

          // 현재 값의 status Level 구하기
          // 대표적으로 보여줄 데이터를 pm10으로 특정해줌.
          final status = DataUtils.getStatusFromItemCodeAndValue(
              value: recentStat.getLevelFromRegion(region),
              itemCode: ItemCode.PM10
          );

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
                  stat: recentStat,
                  status: status,
                  dateTime: recentStat.dataTime,
                  isExpanded: isExpanded,
                ),
                SliverToBoxAdapter(
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CategoryCard(
                            region: region,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ...ItemCode.values.map((itemCode) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HourlyCard(
                                darkColor: status.darkColor,
                                lighColor: status.lightColor,
                                region: region,
                                itemCode: itemCode,
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 8.0,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
