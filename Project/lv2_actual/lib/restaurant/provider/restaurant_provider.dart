import 'dart:math';

import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';
import 'package:lv2_actual/common/provider/pagination_provider.dart';
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    StateProvider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  // 데이터가 어차피 없다는 뜻임, 정상적으로 호출된 상태가 아니기 때문에(로딩 중이거나 에러 발생했음)
  if (state is! CursorPagination) {
    return null;
  }

  // 내가 선택한 id와 같은 id를 가진 데이터를 찾아서 반환
  // firstWhere는 null을 반환할 수 있기 때문에 fisrtWhereOrNull을 사용
  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return RestaurantStateNotifier(repository: repository);
});

// Cursor Pagination > CursorPaginationMeta > hasMore를 보면
// true일 경우 다음 페이지가 있다는 것을 의미 이러한 상태를 조작하기 위해서 List<RestaurantModel>을 CursorPagination으로 변경
class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  // RestaurantStateNotifier가 처음 실행되면 Loading 상태로 시작
  RestaurantStateNotifier({required super.repository});

  void getDetail({
    // 가져오려는 상세 모델
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면
    if (state is! CursorPagination) {
      await paginate();
    }

    // CursorPagination을 했는데 state가 CursorPagination이 아닐 때
    // 뭔가 서버에서 에러가 있거나해서 오류가 났을 때
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination; // 현재 restaurant 상태
    final resp = await repository.getRestaurantDetail(id: id); // 상세 데이터

    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // 요청 id: 10 : list.where((e) => e.id == 10) => null // 에러 발생
    // 음식 탭에서 첫 페이지에서 불러오지 않은 restaurant의 상세 페이지를 불러올 때 발생하는 버그를 방지하기 위함
    if (pState.data.where((e) => e.id == id).isEmpty) {
      // pState, 즉 현재 restaurant list에 없는 id가 들어왔지만 resp에는 데이터가 있음
      // 이 데이터를 현재 state의 restaurant list에 restaurantModel로 추가
      state = pState.copyWith(data: <RestaurantModel>[...pState.data, resp]);
    } else {
      // 요청한 데이터와 일치하는 id값을 가진 데이터를 현재 상태에서 가져옴
      // pState안에 있는 데이터의 id가 함수에서 입력한 id와 같다면 새로 요청한 데이터를 넣고
      // 아니라면 그냥 데이터를 그대로 놔둠
      state = pState.copyWith(
          data: pState.data
              .map<RestaurantModel>((e) => e.id == id ? resp : e)
              .toList());
    }
  }

  bool isLoading(final state) =>
      (state is CursorPaginationLoading) ||
      (state is CursorPaginationRefetching) ||
      (state is CursorPaginationRefetching);
}
