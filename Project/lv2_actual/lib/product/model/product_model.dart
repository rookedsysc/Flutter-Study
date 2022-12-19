import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/common/utils/data_utils.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;
  // 상품 이름
  final String name;
  // 상품 상세정보
  final String detail;
  // 이미지 URL
  @JsonKey(
    fromJson: DataUtils.pathToUrl
  )
  final String imgUrl;
  // 상품 가격
  final int price;
  // 레스토랑 정보 
  // 상품 눌렀을 때 레스토랑으로 이동하기 위함
  final RestaurantModel restaurant;

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}