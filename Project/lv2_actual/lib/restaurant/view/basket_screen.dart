import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/common/layout/default_layout.dart';
import 'package:lv2_actual/product/component/product_card.dart';
import 'package:lv2_actual/user/provider/basket_provider.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => "basket";
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    if (basket.isEmpty) {
      return const DefaultLayout(
        title: "장바구니",
        child: Center(
            child: Text(
          '장바구니가 비어있습니다.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    //: 장바구니에 담긴 상품 전체 가격
    final productsPrice =
        basket.fold<int>(0, (p, n) => p + n.product.price * n.count);
    //: 배달 요금
    final deliveryFee = basket[0].product.restaurant.deliveryFee;
    return DefaultLayout(
      title: "장바구니",
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: ((_, index) {
                    final model = basket[index];
                    return ProductCard.fromProductModel(
                      model: model.product,
                      onAdd: () {
                        ref
                            .read(basketProvider.notifier)
                            .addToBasket(product: model.product);
                      },
                      onSubtract: () {
                        ref
                            .read(basketProvider.notifier)
                            .removeFromBasket(product: model.product);
                      },
                    );
                  }),
                  itemCount: basket.length,
                  separatorBuilder: (_, index) {
                    return const Divider(
                      height: 32.0,
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "장바구니 금액",
                        style: TextStyle(color: BODY_TEXT_COLOR),
                      ),
                      Text(
                          //: 모든 값들의 가격과 개수를 곱해서 basket item의 총 값을 구해줌
                          "₩" + productsPrice.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "배달비",
                        style: TextStyle(color: BODY_TEXT_COLOR),
                      ),
                      if (basket.isNotEmpty) Text("₩" + deliveryFee.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "총액",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                          //: 배달 요금 + 상품 전체 가격
                          "₩" + (deliveryFee + productsPrice).toString()),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("결제하기"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
