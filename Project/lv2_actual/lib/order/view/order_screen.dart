import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/component/pagination_list_view.dart';
import 'package:lv2_actual/order/component/order_card.dart';
import 'package:lv2_actual/order/model/order_model.dart';
import 'package:lv2_actual/order/provider/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
        provider: orderProvider,
        itemBuilder: <OrderModel>(_, index, model) {
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
