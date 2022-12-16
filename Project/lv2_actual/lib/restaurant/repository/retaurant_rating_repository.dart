import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';
import 'package:lv2_actual/common/repository/base_pagination_repository.dart';
import 'package:lv2_actual/rating/model/rating_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';


part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider = Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestaurantRatingRepository(dio, baseUrl: '/restaurants/$id/rating');
});

// http://ip/restaurants/:rid/rating (기본 URL)
@RestApi()
abstract class RestaurantRatingRepository implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) = _RestaurantRatingRepository;
  
  @override
  @GET('/')
  @Headers({
    'accessToken' : 'true' 
  })
  // CursorPagination의 Generic이 Rating Model이라
  // List<RatingModel>이 들어감
  Future<CursorPagination<RatingModel>> paginate({
    // URL path segment에 해당하는 부분을 Name parameter로 지정 
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}