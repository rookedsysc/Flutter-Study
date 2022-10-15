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

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    final StatModel = await StatRepository.fetchData();

    print(StatModel);
  }

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
                CategoryCard(),
                const SizedBox(height: 16.0,),
                HourlyCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
