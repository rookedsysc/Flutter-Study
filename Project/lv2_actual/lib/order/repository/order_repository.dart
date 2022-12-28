import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/order/model/order_model.dart';
import 'package:lv2_actual/order/model/post_order_body.dart';
import 'package:retrofit/retrofit.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);
  
  return OrderRepository(dio, baseUrl: "http://$ip/order");
});

//+ BaseUrl : http://$ip/order
@RestApi()
abstract class OrderRepository {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @POST('/')
  @Headers({
    "accessToken": "true"
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });

}