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
import 'package:lv2_actual/restaurant/riverpod/restaurant_provider.dart';
import 'package:lv2_actual/restaurant/view/restaurant_screen.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {

  // RestaurantDetail 받아오는 함수
  Future<RestaurantDetailModel> getRestaurantDetail({required WidgetRef ref}) async {
    final dio = ref.watch(dioProvider);

    final repositroy = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    
    return repositroy.getRestaurantDetail(id: widget.id);
  }

  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // 레스토랑 프로바이더에 이미 있는 데이터를 가져오기 때문에 로딩이 걸리지 않음
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if(state != null) {
      return DefaultLayout(
        title: state.name,
        child: CustomScrollView(
          slivers: [
            // 레스토랑 정보
            renderTop(model: state),
            if(state is RestaurantDetailModel)renderLabel(),
            // 레스토랑 메뉴
            if(state is RestaurantDetailModel)renderProducts(products: state.products)
          ],
        ),
      );
    }

    return const DefaultLayout(
      child: Center(
        child: CircularProgressIndicator(),
      ),
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

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
        child: RestaurantCard.fromModel(
          model: model,
          isDetail: true,
        ),
      );
  }
}
