import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';
import 'package:lv2_actual/common/repository/base_pagination_repository.dart';
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

// code generation을 해줄거기 때문에 part 사용
part 'restaurant_repository.g.dart';


final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

  return repository;
});

// 인스턴스화가 되지 않게 abstract로 선언
@RestApi()
// implements를 해줌으로써 현재 class에 반드시 paginate() 합수가 있음을 암시
abstract class RestaurantRepository implements IBasePaginationRepository<RestaurantModel> { 
  // factory constuctor는 (=)을 사용해서 함수 Body를 지정해줄 수 있음
  // 함수 Body를 RestaurantRepository로 지정함
  factory RestaurantRepository(Dio dio, {String baseUrl/*http://$ip/restaurant*/}) 
  = _RestaurantRepository;

  // 요청 방식과 baseUrl 뒤에 붙을 path를 지정해줌
  // 이 기준을 보고서 retrofit이 이 파일 안에다가 각각의 함수가 어떻게 실행되어야 하는지 정의를 하게 됨
  @override
  @GET('/')
  @Headers({
    'accessToken' : 'true' 
  })
  // after와 count의 값이 없어도 API 요청에는 문제가 없음 
  Future<CursorPagination<RestaurantModel>> paginate({
    // 해당하는 클래스를 HTTP query parameter로 지정
    @Queries() PaginationParams? paginationParams = const PaginationParams(), // 기본 값은 반드시 cons로 지정
  });


  // http://$ip/restaurant/{id}
  @GET('/{id}')
  @Headers({
    // accessToken이라는 이름의 Header를 true로 지정해서 dio 호출을 보냄
    // 그러면 해당하는 header의 값을 interceptor에서 options.headers['accessToken']으로 읽을 수 있음
    // 이를 통해서 interceptor에서 accessToken을 읽어서 interceptor에서 header에 accessToken을 넣어줄 수 있음
    'accessToken' : 'true' 
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    // URL path segment에 해당하는 부분을 Name parameter로 지정 
    @Path('id') required String id,
  });

}