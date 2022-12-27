import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/product/model/product_model.dart';
import 'package:lv2_actual/user/model/basket_item_model.dart';
import 'package:collection/collection.dart';


final basketProvider = StateNotifierProvider<BasketNotifier, List<BasketItemModel>>((ref) {
  return BasketNotifier();
});

class BasketNotifier extends StateNotifier<List<BasketItemModel>> {
  BasketNotifier() : super([]);

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    //: 해당하는 상품이 장바구니에 있는지 확인
    final exists = state.firstWhereOrNull((element) => element.product.id == product.id) != null;

    //: 장바구니에 해당되는 상품이 있을 경우
    if (exists) {
      state = state
          .map<BasketItemModel>(
            (e) =>
                e.product.id == product.id ? e.copyWith(count: e.count + 1) : e,
          )
          .toList();
    }
    // :아직 장바구니에 해당되는 상품이 없을 경우
    else {
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        )
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool forceDelete = false,
  }) async {
    //: 해당하는 상품이 장바구니에 있는지 확인
    final exists = state.firstWhereOrNull((element) => element.product.id == product.id) != null;

    //: 없는데 요청이 왔을 경우
    if(!exists) {
      return;
    }

    final BasketItemModel existingProduct = state.firstWhere((e) => e.product.id == product.id);

    //: 강제삭제 or count가 1인 경우
    if(existingProduct.count == 1) {
      //: product id가 같은거 빼고 다 가져옴(삭제)
      state = state.where((e) => e.product.id != product.id).toList();
    } else {
      state = state
          .map<BasketItemModel>((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }
  }
}
