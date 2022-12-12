import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';
import 'package:lv2_actual/restaurant/riverpod/restaurant_provider.dart';
import 'package:lv2_actual/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  // json 데이터에서 data 키 안의 Resstaurant 배열을 가져오는 함수
  Future<List<RestaurantModel>> paginateRestaurant({required WidgetRef ref}) async {
    final dio = ref.watch(dioProvider);
    final CursorPagination<RestaurantModel> resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // autoDispose를 사용하지 않았기 때문에 해당하는 Provider가 한 번 호출이 계속 생성이 된 상태로 있는다.
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {

      // 현재 데이터의 타입은 CursorPaginationBase임
      // 여기에서는 Data를 정상적으로 받아왔을 경우이므로 Data를 정상적으로 받아온 경우 Typedms CursorPagination임
      // 따라서 data를 CursorPagination으로 형변환을 해줌 
      final cp = data as CursorPagination;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
          itemCount: cp.data.length,
          itemBuilder: (context, index) {
            final pItem = cp.data[index];

            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                      id: pItem.id,
                    ),
                  ));
                },
                child: RestaurantCard.fromModel(model: pItem));
            // return RestaurantCard(
            //   image: Image.network(
            //     snapshot.data!.data.thumbUrl,
            //     fit: BoxFit.cover,
            //   ),
            //   name: snapshot.data!.data.name,
            //   tags: snapshot.data!.data.tags,
            //   ratingsCount: snapshot.data!.data.ratingsCount,
            //   deliveryTime: snapshot.data!.data.deliveryTime,
            //   deliveryFree: snapshot.data!.data.deliveryFee,
            //   ratings: snapshot.data!.data.ratings,
            // );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
        ),
      );
    }
  }
}
