import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/order/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productsDetail;
  final int price;

  //: class에 선언한 변수 한 번에 constuctor로 가져오기
  const OrderCard(
      {required this.orderDate,
      required this.image,
      required this.name,
      required this.productsDetail,
      required this.price,
      super.key});

  factory OrderCard.fromModel({required OrderModel model}) {
    //: 상품의 개수가 1개일 때는 첫 번째 상품의 이름을 그냥 보여줌
    //: 그 외의 상황에는 첫 번째 상품 외에 몇 개의 상품이 더 있는지 보여주게 됨
    final productsDetail = model.products.length < 2
        ? model.products.first.product.name
        : '${model.products.first.product.name} 외 ${model.products.length - 1}개';

    return OrderCard(
        orderDate: model.createdAt,
        image: Image.network(
          model.restaurant.thumbUrl,
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
        name: model.restaurant.name,
        productsDetail: productsDetail,
        price: model.totalPrice);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //: 2022.09.01
        Text(
            '${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 주문완료'),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: image,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //: 상품이름
                Text(
                  name,
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  '$productsDetail $price원',
                  style: TextStyle(
                      color: BODY_TEXT_COLOR, fontWeight: FontWeight.w300),
                )
              ],
            )
          ],
        )

      ],
    );
  }
}
