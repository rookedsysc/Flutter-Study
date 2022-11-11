import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/layout/default_layout.dart';
import 'package:riverpod_sample/model/shopping_item_model.dart';
import 'package:riverpod_sample/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget{
  const StateNotifierProviderScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ShoppingItemModel> state = ref.watch(shoppingListNotifier);


    return DefaultLayout(title: 'State Notifier Provider Screen',
        body: ListView(
          children: state.map((e) => CheckboxListTile(
            title: Text(e.name),
            value: e.hasBought, onChanged: (value){
              // .notifier를 붙이면 class가 그대로 옴, 그래서 내부에 선언된 함수에 바로 접근이 가능함
              ref.read(shoppingListNotifier.notifier).toggleHasBought(name: e.name);
            }),
        ).toList(),
        ),
    );
  }
}