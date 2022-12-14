import 'dart:html';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';
import 'package:lv2_actual/common/repository/base_pagination_repository.dart';

class _PaginationInfo {
  final int fetchCount; // count
  // 추가로 데이터를 가져오는지 여부
  // true - 추가로 데이터 더 가져옴
  // false - 새로고침 (현재 상태를 덮어씌움)
  final bool fetchMore;
  // 강제로 다시 로딩하기
  // true - CursorPaginationLoading 상태로 변경
  final bool forceRefetch;

  _PaginationInfo(
      {this.fetchCount = 20,
      this.fetchMore = false,
      this.forceRefetch = false});
}

// U는 IBasePaginationRepository 타입임을 명시해줌
// 제너릭에서는 implements를 사용할 수 없기 때문에 extends를 사용
class PaginationProvider<
// 페이지 네이션에서 가져오는 값들의 실제 데이터 타입
        T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  // Future<CursorPagination<T>> paginate
  // 각 repository마다 다른 타입의 데이터를 가져올 수 있기 때문에
  final U repository;
  
  //* pagination 함수를 throttle을 이용해서 실행함
  //+ checkEquality : 함수 실행할 때 넣는 값이 같으면 실행하지 않음
  final paginationThrottle = Throttle(Duration(seconds: 1),
      initialValue: _PaginationInfo(), checkEquality: false);

  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
        paginate();

        //* setvalue 실행시 loop back 실행됨
        paginationThrottle.values.listen((state) {
          _throttlePagination(state);
        });
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
    //* pagination throttle을 통해서 실행함
    //: setValue에는 인자를 하나 밖에 전달할 수 없기 때문에 class로 묶어줌
    paginationThrottle.setValue(_PaginationInfo(
      fetchMore: fetchMore,
      forceRefetch: forceRefetch,
      fetchCount: fetchCount
    ));
  }

  _throttlePagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;
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
            as CursorPagination<T>; // CursorPagination > CursorPaginationBase

        // 1)번 상황
        // meta가 중요한 상황이라 따로 T 타입을 넣어주지 않음
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
        // IModelWithId를 상속받은 데이터 타입을 들고 있는 상태
        final pState = state as CursorPagination<T>;

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
          final pState = state as CursorPagination<T>;
          // 데이터는 있는데 새로고침을 하고 있음
          state = CursorPaginationRefetching<T>(
              meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      // 마지막 데이터의 id를 paginationParams에 넣고/최초 실행일 경우 기본 paginate를 넣고 paginate 실행
      // repository는 받아오는 데이터에 따라서 달라짐
      final resp =
          await repository.paginate(paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;
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
    } catch (e, stack) {
      print(e);
      print("[!] Error Stack : $stack");
      // 에러 발생한 상황
      state = CursorPaginationError(
          message: "[!] [Error Alert] $e\n\r데이터를 가져오지 못했습니다.");
    }
  }

  bool isLoading(final state) =>
      (state is CursorPaginationLoading) ||
      (state is CursorPaginationRefetching) ||
      (state is CursorPaginationRefetching);
}
