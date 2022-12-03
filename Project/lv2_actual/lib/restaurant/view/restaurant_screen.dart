import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: RestaurantCard(
            image:
                Image.asset('asset/img/food/ddeok_bok_gi.jpg', fit: BoxFit.cover),
            name: "불타는 떡복이",
            tags: ["떡복이", "치즈", "매운맛"],
            ratingCount: 100,
            deliveryTime: 15,
            deliveryFree: 2000,
            rating: 4.52),
      ),
    );
  }
}