import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';
import 'package:lv2_actual/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  // json 데이터에서 data 키 안의 Resstaurant 배열을 가져오는 함수
  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor(storage: storage));

    final CursorPagination<RestaurantModel> resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();


    return resp.data;
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

                final pItem = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(id: pItem.id,),
                    ));
                  },
                    child: RestaurantCard.fromModel(
                        model: pItem));
                // return RestaurantCard(
                //   image: Image.network(
                //     snapshot.data!.thumbUrl,
                //     fit: BoxFit.cover,
                //   ),
                //   name: snapshot.data!.name,
                //   tags: snapshot.data!.tags,
                //   ratingsCount: snapshot.data!.ratingsCount,
                //   deliveryTime: snapshot.data!.deliveryTime,
                //   deliveryFree: snapshot.data!.deliveryFee,
                //   ratings: snapshot.data!.ratings,
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
