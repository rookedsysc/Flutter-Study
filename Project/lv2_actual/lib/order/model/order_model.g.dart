// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      detail: json['detail'] as String,
      id: json['id'] as String,
      imgUrl: DataUtils.pathToUrl(json['imgUrl'] as String),
      name: json['name'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
    };

OrderProductAndCountModel _$OrderProductAndCountModelFromJson(
        Map<String, dynamic> json) =>
    OrderProductAndCountModel(
      product:
          OrderProductModel.fromJson(json['product'] as Map<String, dynamic>),
      count: json['count'] as int,
    );

Map<String, dynamic> _$OrderProductAndCountModelToJson(
        OrderProductAndCountModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'count': instance.count,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) =>
              OrderProductAndCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
      restaurant:
          RestaurantModel.fromJson(json['restaurant'] as Map<String, dynamic>),
      createAt: DataUtils.stringToDateTime(json['createAt'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'totalPrice': instance.totalPrice,
      'restaurant': instance.restaurant,
      'createAt': instance.createAt.toIso8601String(),
    };
