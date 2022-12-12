import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/product/component/product_card.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  // RestaurantDetail 받아오는 함수
  Future<RestaurantDetailModel> getRestaurantDetail({required WidgetRef ref}) async {
    final dio = ref.watch(dioProvider);

    final repositroy = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    
    return repositroy.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '불타는 떡볶이',
        child: FutureBuilder<RestaurantDetailModel>(
          future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
          builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {

            if(!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // retorfit으로 대체
            // final item = RestaurantDetailModel.fromJson(snapshot.data!);

            return CustomScrollView(
              slivers: [
                // 레스토랑 정보
                renderTop(model: snapshot.data!),
                renderLabel(),
                // 레스토랑 메뉴
                renderProducts(products: snapshot.data!.products)
              ],
            );
          }
        )
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Text(
              '메뉴',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );

  }

  SliverPadding renderProducts({required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = products[index];

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard.fromModel(model: model),
          );
        }, childCount: products.length),
      ),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantDetailModel model}) {
    return
      SliverToBoxAdapter(
        child: RestaurantCard.fromModel(
          model: model,
          isDetail: true,
        ),
      );
  }
}