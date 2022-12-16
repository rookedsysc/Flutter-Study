import 'dart:math';

import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';
import 'package:riverpod/riverpod.dart';



final restaurantDetailProvider = StateProvider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  // 데이터가 어차피 없다는 뜻임, 정상적으로 호출된 상태가 아니기 때문에(로딩 중이거나 에러 발생했음)
  if(state is! CursorPagination) {
    return null;
  }

  // 내가 선택한 id와 같은 id를 가진 데이터를 찾아서 반환
  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  return RestaurantStateNotifier(repository);
});



// Cursor Pagination > CursorPaginationMeta > hasMore를 보면
// true일 경우 다음 페이지가 있다는 것을 의미 이러한 상태를 조작하기 위해서 List<RestaurantModel>을 CursorPagination으로 변경
class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  // RestaurantStateNotifier가 처음 실행되면 Loading 상태로 시작
  RestaurantStateNotifier(this.repository) : super(CursorPaginationLoading()) {
    // 시작시 첫 페이지를 로드
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20, // count
    // 추가로 데이터를 가져오는지 여부
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading 상태로 변경
    bool forceRefetch = false,
  }) async {
    try {
      // CursorPagination - 정상적으로 데이터가 있는 상태
      // CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음0)
      // CursorPaginationError - 에러가 있는 상태
      // CursorPaginationRefetching - 첫 번째 페이지부터 다시 데이터를 가져올 때
      // CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

      // 바로 반환하는 상황
      // 1) haseMore == false(기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면)
      // 더 이상 pagination을 실행할 필요가 없음
      // 2) 로딩 중 - fetchMore == true
      // 리스트의 맨 아래로 가서 추가 데이터를 가져오라는 요청을 받았을 때
      //    fetchMore가 아닐 때 - 새로고침을 했을 때
      if (state is CursorPagination && !forceRefetch) {
        final pState = state
            as CursorPagination; // CursorPagination > CursorPaginationBase

        // 1)번 상황
        if (!pState.meta.hasMore) {
          return;
        }
      }
      // 2)번 상황
      if (fetchMore && isLoading(state)) {
        return;
      }

      // Pagination Params 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        // fetchMore를 실행할 수 있는 상황은 이미 데이터를 불러온 상황이므로 CursorPagination이 들고 있는 상태
        final pState = state as CursorPagination;

        // 현재 상태를 인자 값을 그대로 유지한 채로
        // CursorPaginationFetchMore로 변경
        state =
            CursorPaginationFetchingMore(data: pState.data, meta: pState.meta);
        paginationParams = paginationParams.copyWith(
          // after 값에 현재 데이터(상태)의 마지막 데이터의 id를 넣어줌
          after: pState.data.last.id,
        );
      } /* 데이터를 처음부터 가져오는 상황 */ else {
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로  Fetch(API 요청)를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          // 데이터는 있는데 새로고침을 하고 있음
          state =
              CursorPaginationRefetching(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      // 마지막 데이터의 id를 paginationParams에 넣고/최초 실행일 경우 기본 paginate를 넣고 paginate 실행
      // repository는 받아오는 데이터에 따라서 달라짐
      final resp =
          await repository.paginate(paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        // 현재 상태를 CursorPagination으로 변경
        state = resp.copyWith(
            // 새로 받아온 데이터를 최근의 데이터 뒤에 붙여줌
            data: [...pState.data, ...resp.data]);
      }
      // CursorPaginationLoading이거나 CursorPaginationRefetching인 상황
      else {
        // 처음 데이터를 가져오는 상황이므로 응답값을 그대로 적용
        state = resp;
      }
    } catch (e) {
      // 에러 발생한 상황
      state = CursorPaginationError(message: "[!] [Error Alert] $e\n\r데이터를 가져오지 못했습니다.");
    }
  }



  void getDetail({ 
    // 가져오려는 상세 모델
    required String id,
  }) async { 
    // 만약에 아직 데이터가 하나도 없는 상태라면 
    if(state is !CursorPagination) {
      await this.paginate();
    } 

    // CursorPagination을 했는데 state가 CursorPagination이 아닐 때
    // 뭔가 서버에서 에러가 있거나해서 오류가 났을 때 
    if(state is !CursorPagination) {
      return;
    }

    final pState = state as CursorPagination; // 현재 restaurant 상태
    final resp = await repository.getRestaurantDetail(id: id); // 상세 데이터

    // 요청한 데이터와 일치하는 id값을 가진 데이터를 현재 상태에서 가져옴
    // pState안에 있는 데이터의 id가 함수에서 입력한 id와 같다면 새로 요청한 데이터를 넣고 
    // 아니라면 그냥 데이터를 그대로 놔둠
    state = pState.copyWith(
      data: pState.data.map<RestaurantModel>((e) => e.id == id ? resp : e).toList()
    );
  }
  

  bool isLoading(final state) =>
      (state is CursorPaginationLoading) ||
      (state is CursorPaginationRefetching) ||
      (state is CursorPaginationRefetching);



  
}
