import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/model/shopping_item_model.dart';
import 'package:riverpod_sample/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  final filterState = ref.watch(filterProvider);
  final List<ShoppingItemModel> shoppingListState = ref.watch(shoppingListNotifier);

  if(filterState == FilterState.all) {
    return shoppingListState;
  }

  return shoppingListState.where((element) => filterState == FilterState.spicy ? element.isSpicy : !element.isSpicy).toList();
});

final filterProvider = StateProvider((ref) => FilterState.all);

enum FilterState {
  spicy,
  notSpicy,
  all
}