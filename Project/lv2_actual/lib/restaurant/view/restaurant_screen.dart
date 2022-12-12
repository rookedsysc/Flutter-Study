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

class RestaurantScreen extends ConsumerStatefulWidget{
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  // json 데이터에서 data 키 안의 Resstaurant 배열을 가져오는 함수
  Future<List<RestaurantModel>> paginateRestaurant(
      {required WidgetRef ref}) async {
    final dio = ref.watch(dioProvider);
    final CursorPagination<RestaurantModel> resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();
    return resp.data;
  }

  @override
  void initState() {
    controller.addListener(scrollListener);

    super.initState();
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    if (controller.offset >=
        controller.position.maxScrollExtent - 300) {
      // ref.read를 사용하면 해당하는 Provider가 한 번 호출이 계속 생성이 된 상태로 있음
      ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    }

  }

  @override
  Widget build(BuildContext context) {
    // autoDispose를 사용하지 않았기 때문에 해당하는 Provider가 한 번 호출이 계속 생성이 된 상태로 있는다.
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPaggination || CursorPagginationFetchingMore || CursorPagginationRefetching 
    // 현재 데이터의 타입은 CursorPaginationBase임
    // 여기에서는 Data를 정상적으로 받아왔을 경우이므로 Data를 정상적으로 받아온 경우 Typedms CursorPagination임
    // 따라서 data를 CursorPagination으로 형변환을 해줌
    final cp = data as CursorPagination;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Scrollbar(
        controller: controller,
        child: ListView.separated(
          controller: controller,
          itemCount: cp.data.length + 1, // +1은 로딩을 위해서 
          itemBuilder: (context, index) { 
            if(index == cp.data.length) {
              // 데이터가 FetchingMore(로딩 중)인 경우에만 ProgressIndicator를 보여줌
              return Center(child: data is CursorPaginationFetchingMore ? const CircularProgressIndicator() : const SizedBox());
            }

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
      ),
    );
  }
}
