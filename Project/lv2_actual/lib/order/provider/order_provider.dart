
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/provider/pagination_provider.dart';
import 'package:lv2_actual/order/model/order_model.dart';
import 'package:lv2_actual/order/model/post_order_body.dart';
import 'package:lv2_actual/order/repository/order_repository.dart';
import 'package:lv2_actual/user/provider/basket_provider.dart';
import 'package:uuid/uuid.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>((ref) {  
  final repo = ref.watch(orderRepositoryProvider);
  return OrderStateNotifier(ref: ref, repository: repo);
});

class OrderStateNotifier extends PaginationProvider<OrderModel, OrderRepository> {
  final Ref ref;
  OrderStateNotifier({required super.repository, required this.ref});

  Future<bool> postOrder() async {
    try {
      //: 시간을 기준으로 랜덤으로 id가 생성이 됨
      final uuid = Uuid();
      final id = uuid.v4();

      final state = ref.read(basketProvider);
      final resp = await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map((e) => PostOrderBodyProduct(
                    productId: e.product.id,
                    count: e.count,
                  ))
              .toList(),
          createdAt: DateTime.now().toString(),
          totalPrice:
              state.fold<int>(0, (p, n) => p + n.count * n.product.price),
        ),
      );
      return true;
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      return false;
    }
  }
}
