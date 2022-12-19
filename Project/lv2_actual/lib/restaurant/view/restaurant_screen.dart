import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/component/pagination_list_view.dart';
import 'package:lv2_actual/common/const/data.dart';
import 'package:lv2_actual/common/dio/dio.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/utils/pagination_utils.dart';
import 'package:lv2_actual/restaurant/component/restaurant_card.dart';
import 'package:lv2_actual/restaurant/model/restaurant_model.dart';
import 'package:lv2_actual/restaurant/repository/restaurant_repository.dart';
import 'package:lv2_actual/restaurant/provider/restaurant_provider.dart';
import 'package:lv2_actual/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(provider: restaurantProvider, itemBuilder: <RestaurantModel>(context, index, model) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(
                id: model.id,
              ),
            ),
          );
        },
        child: RestaurantCard.fromModel(
          model: model,
          heroKey: model.id,
        ),
      ),
    );
  }
}
