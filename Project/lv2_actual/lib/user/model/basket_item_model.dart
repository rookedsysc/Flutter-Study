

import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/product/model/product_model.dart';

part 'basket_item_model.g.dart';

@JsonSerializable()
class BasketItemModel {
  final ProductModel product;
  final int count;

  BasketItemModel({
    required this.product,
    required this.count,
  });

  copyWith({
    ProductModel? product,
    int? count,
  }) {
    return BasketItemModel(
      product: product ?? this.product,
      count: count ?? this.count,
    );
  }


  factory BasketItemModel.fromJson(Map<String, dynamic> json) => _$BasketItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$BasketItemModelToJson(this);
}
