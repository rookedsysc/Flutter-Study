import 'package:dio/dio.dart' hide Headers;
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

// 인스턴스화가 되지 않게 abstract로 선언
@RestApi()
abstract class RestaurantRepository {
  // factory constuctor는 (=)을 사용해서 함수 Body를 지정해줄 수 있음
  //함수 Body를 RestaurantRepository로 지정함
  factory RestaurantRepository(Dio dio, {String baseUrl/*http://$ip/restaurant*/}) 
  = _RestaurantRepository;

  // 요청 방식과 baseUrl 뒤에 붙을 path를 지정해줌
  // 이 기준을 보고서 retrofit이 이 파일 안에다가 각각의 함수가 어떻게 실행되어야 하는지 정의를 하게 됨
  // @GET('/')
  // paginate() {

  // }

  // http://$ip/restaurant/{id}
  @GET('/{id}')
  @Headers({
    'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjcwMzM3ODgxLCJleHAiOjE2NzAzMzgxODF9.PsP4LBiHvNDg_unywmT8J2F3yBy6fXTjjt_YCgXAfuc',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    // URL path segment에 해당하는 부분을 Name parameter로 지정 
    @Path('id') required String id,
  });

}