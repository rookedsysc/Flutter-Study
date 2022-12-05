import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/view/rstaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  // json 데이터에서 data 키 안의 Resstaurant 배열을 가져오는 함수
  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get('http://$ip/restaurant',
        options: Options(headers: {
          'authorization': 'Bearer $accessToken',
        }));

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
          future: paginateRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // parsed
                final pItem = RestaurantModel.fromJson(json: snapshot.data![index]);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(),
                    ));
                  },
                    child: RestaurantCard.fromRestaurantModel(
                        restaurantModel: pItem));
                // return RestaurantCard(
                //   image: Image.network(
                //     pItem.thumbUrl,
                //     fit: BoxFit.cover,
                //   ),
                //   name: pItem.name,
                //   tags: pItem.tags,
                //   ratingsCount: pItem.ratingsCount,
                //   deliveryTime: pItem.deliveryTime,
                //   deliveryFree: pItem.deliveryFee,
                //   ratings: pItem.ratings,
                // );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
            );
          },
        ),
      ),
    );
  }
}
