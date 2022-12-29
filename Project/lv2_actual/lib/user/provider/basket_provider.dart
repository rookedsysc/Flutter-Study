import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/product/model/product_model.dart';
import 'package:lv2_actual/user/model/basket_item_model.dart';
import 'package:collection/collection.dart';
import 'package:lv2_actual/user/model/patch_basket_body.dart';
import 'package:lv2_actual/user/repository/user_me_repository.dart';


final basketProvider = StateNotifierProvider<BasketNotifier, List<BasketItemModel>>((ref) {
  final repository = ref.watch(userMeRepositoryProvider);
  return BasketNotifier(repository: repository);
});

class BasketNotifier extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  //* Debounce 
  final updateBasketDebounce = Debouncer(Duration(seconds: 3), initialValue: null, checkEquality: false);

  BasketNotifier({required this.repository}) : super([]) {
    //: 추가를 하던 제거를 하든 Debounce기간 이후에 더 이상 실행되는 함수가 없을 경우에만 
    //: patchBasket() 함수가 실행이 됨
    updateBasketDebounce.values.listen((event) {
      patchBasket();
    });
  }

  Future<void> patchBasket() async {
    await repository.patchBasket(body: PatchBasketBody(basket: state.map((e) => PatchBasketBodyBasket(productId: e.product.id, count: e.count)).toList()));
  }

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

    //* Optimisitic Responese(긍정적 응답)
    //: 응답이 성골할거라고 가정하고 상태를 먼저 업데이트 함
    updateBasketDebounce.setValue(null);
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
    updateBasketDebounce.setValue(null);
  }
}
