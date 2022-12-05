import 'package:flutter/material.dart';
import 'package:lv2_actual/common/const/colors.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 레스토랑 이름
  final String name;
  // 레스토랑 태그
  final List<String> tags;
  // 평점 갯수
  final int ratingsCount;
  // 배송 걸리는 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFree;
  // 평균 평점
  final double ratings;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFree,
    Key? key, required this.ratings}) : super(key: key);

  factory RestaurantCard.fromRestaurantModel ({
    required RestaurantModel restaurantModel,
  }) {
    return RestaurantCard(
      image: Image.network(
        restaurantModel.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: restaurantModel.name,
      tags: restaurantModel.tags,
      ratingsCount: restaurantModel.ratingsCount,
      deliveryTime: restaurantModel.deliveryTime,
      deliveryFree: restaurantModel.deliveryFee,
      ratings: restaurantModel.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 테두리를 깍을 수 있음
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              // join
              tags.join(' · '),
              style: const TextStyle(
                fontSize: 14.0,
                color: BODY_TEXT_COLOR,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                _IconText(
                  icon: Icons.star,
                  label: ratings.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.receipt,
                  label: ratingsCount.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.timelapse_outlined,
                  label: '$deliveryTime 분',
                ),
                renderDot(),
                _IconText(
                    icon: Icons.monetization_on,
                    label: deliveryFree == 0 ? '무료' : '$deliveryFree 원'),
              ],
            ),
            const SizedBox(height: 8.0),

          ],
        ),
      ],
    );
  }

  renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        ' · ',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconText({required this.icon, required this.label, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            color: BODY_TEXT_COLOR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
