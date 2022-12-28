import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/common/utils/data_utils.dart';
import 'package:lv2_actual/user/model/basket_item_model.dart';


part 'post_order_body.g.dart';

//* 주문할 때 보내는 요청 (Request)
@JsonSerializable()
class PostOrderBody {
  final String id;
  final List<PostOrderBodyProduct> products;
  final int totalPrice;
  final String createAt;

  PostOrderBody({
    required this.id,
    required this.products,
    required this.createAt,
    required this.totalPrice
  });

  factory PostOrderBody.fromJson(Map<String, dynamic> json) => _$PostOrderBodyFromJson(json);
  Map<String, dynamic> toJson() => _$PostOrderBodyToJson(this);
}


@JsonSerializable()
class PostOrderBodyProduct {
  final String productId;
  final int count; 

  PostOrderBodyProduct({
    required this.count,
    required this.productId
  });

  factory PostOrderBodyProduct.fromJson(Map<String, dynamic> json) => _$PostOrderBodyProductFromJson(json);
  Map<String, dynamic> toJson() => _$PostOrderBodyProductToJson(this);
}