import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/model/shopping_item_model.dart';

// Generic에는 어떤 StateNotifier를 상속한 클래스를 쓸건지 Type으로 넣어주고 두 번째 Generic은 그 클래스가 관리하는 상태의 type을 넣어줌 
final shoppingListNotifier = StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>((ref) => ShoppingListNotifier());

// StateNotifier는 StateNotifier에 제공이 될 class가 상속받는 것
// StateNotifierProivder는 StateNotifier를 상속한 클래스를 Provider로 만들어 주는 것임
class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  ShoppingListNotifier()
      : super([
          // ShoppingListProvider 초기화
          // ShoppingListProvider 선언시 해당하는 값들을 처음에 사용할 수 잇음
          ShoppingItemModel(
              name: '김치', quantity: 3, hasBought: false, isSpicy: true),
          ShoppingItemModel(
              name: '라면', quantity: 5, hasBought: false, isSpicy: true),
          ShoppingItemModel(
              name: '삼겹살', quantity: 10, hasBought: false, isSpicy: false),
          ShoppingItemModel(
              name: '수박', quantity: 2, hasBought: false, isSpicy: false),
          ShoppingItemModel(
              name: '카스테라', quantity: 7, hasBought: false, isSpicy: false),
        ]);

  void toggleHasBought({required String name, }) {
    // state는 StateNotifier에 자동으로 제공됨
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy)
            : e)
        .toList();
  }
}
