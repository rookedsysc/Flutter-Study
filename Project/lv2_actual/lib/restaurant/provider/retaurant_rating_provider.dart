import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';


final restaurantRatingProvider = StateNotifierProvider<RestaurantRatingStateNotifier, CursorPaginationBase>((ref) {
  return RestaurantRatingStateNotifier();
});
class RestaurantRatingStateNotifier
    extends StateNotifier<CursorPaginationBase> {
  RestaurantRatingStateNotifier() : super(CursorPaginationLoading());
}

