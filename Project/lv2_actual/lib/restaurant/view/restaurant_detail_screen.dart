import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/utils/pagination_utils.dart';
import 'package:lv2_actual/product/component/product_card.dart';
import 'package:lv2_actual/product/model/product_model.dart';
import 'package:lv2_actual/rating/component/rating_card.dart';
import 'package:lv2_actual/rating/model/rating_model.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/provider/retaurant_rating_provider.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';
import 'package:lv2_actual/restaurant/provider/restaurant_provider.dart';
import 'package:lv2_actual/restaurant/view/basket_screen.dart';
import 'package:lv2_actual/restaurant/view/restaurant_screen.dart';
import 'package:lv2_actual/user/provider/basket_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:go_router/go_router.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaruantDetail';
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  // RestaurantDetail 받아오는 함수
  Future<RestaurantDetailModel> getRestaurantDetail(
      {required WidgetRef ref}) async {
    final dio = ref.watch(dioProvider);

    final repositroy =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

    return repositroy.getRestaurantDetail(id: widget.id);
  }

  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(restaurantRatingProvider(widget.id).notifier));
  }

  @override
  Widget build(BuildContext context) {
    // 레스토랑 프로바이더에 이미 있는 데이터를 가져오기 때문에 로딩이 걸리지 않음
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (state != null) {
      return DefaultLayout(
        title: state.name,
        floatingActionButton: FloatingActionButton(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            //* go를 하게 되면 routes에 nesting된 (하위)라우트를 그대로 사용하게 되고 
            //* push를 현재 라우트 위에다가 screen을 stack처럼 올리는 방식을 사용할 수 있음 
            // context.goNamed(BasketScreen.routeName);
            context.pushNamed(BasketScreen.routeName);
            
          },
          child: Badge(
            //: 언제 보여줄건지
            showBadge: basket.isNotEmpty,
            //: 어떤걸 보여줄건지
            badgeContent: Text(basket
                .fold<int>(0, (prev, next) => prev + next.count)
                .toString()),
            child: const Icon(Icons.shopping_basket_outlined),
          ),
        ),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            // 레스토랑 정보
            renderTop(model: state),
            // 로딩 시에 스켈레톤
            if (state is! RestaurantDetailModel) renderLoading(),
            // 로딩 끝나면 라벨
            if (state is RestaurantDetailModel) renderLabel(),
            // 레스토랑 메뉴
            if (state is RestaurantDetailModel)
              renderProducts(products: state.products, restaurant: state),
            // Rating 요청
            if (ratingState is CursorPagination<RatingModel>)
              renderRatings(models: ratingState.data),
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

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = models[index];

            return RatingCard.fromModel(
              model: model,
            );
          },
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                // SkeletonParagraph 기본 패딩 제거
                padding: EdgeInsets.zero,
                lines: 5,
              ),
            ),
          ),
        )),
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

  SliverPadding renderProducts(
      {required RestaurantModel restaurant,
      required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = products[index];

          return InkWell(
            onTap: () {
              ref.read(basketProvider.notifier).addToBasket(
                    product: ProductModel(
                        id: model.id,
                        name: model.name,
                        detail: model.detail,
                        imgUrl: model.imgUrl,
                        price: model.price,
                        restaurant: restaurant),
                  );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromRestaurantProductModel(model: model),
            ),
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
        heroKey: model.id,
      ),
    );
  }
}
