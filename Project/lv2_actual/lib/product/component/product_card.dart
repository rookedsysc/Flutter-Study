import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/product/model/product_model.dart';
import 'package:lv2_actual/restaurant/model/restaurant_detail_model.dart';
import 'package:lv2_actual/user/provider/basket_provider.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;


  const ProductCard({
    required this.price,
    required this.detail,
    required this.name,
    required this.image,
    required this.id,
    this.onSubtract, 
    this.onAdd,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        fit: BoxFit.cover,
        width: 110,
        height: 110,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        fit: BoxFit.cover,
        width: 110,
        height: 110,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }


  // Image.asset(
  // 'asset/img/food/ddeok_bok_gi.jpg',
  // width: 110,
  // height: 110,
  // fit: BoxFit.cover,
  // ),

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      // ellipsis: '...',
                      // clip: 초과한 문자열 자름
                      // fade: 초과한 문자열을 흐릿하게 만듬A
                      // visible: 넘어가는 문자열 보이게 만듬
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '₩ $price',
                      style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _footer(
                //: 전체 가격
                total: (basket.firstWhere((e) => e.product.id == id).count *
                        basket
                            .firstWhere((e) => e.product.id == id)
                            .product
                            .price)
                    .toString(),
                //: 상품의 개수
                count: basket.firstWhere((e) => e.product.id == id).count,
                onSubtract: onSubtract!,
                onAdd: onAdd!),
          )
      ],
    );
  }

  Widget _footer({
    required String total,
    required int count,
    required VoidCallback onSubtract,
    required VoidCallback onAdd,
  }) {
    return Row(
      children: [
        Expanded(
            child: Text(
            '총액 $total',
            style: const TextStyle(
                color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            _renderButton(icon: Icons.remove, onTap: onSubtract),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                  color: PRIMARY_COLOR, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 8.0,
            ),
            _renderButton(icon: Icons.add, onTap: onAdd)
          ],
        )
      ],
    );
  }

  Widget _renderButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: PRIMARY_COLOR, width: 1.0)),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
