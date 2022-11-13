import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingItemModel _item1 = ShoppingItemModel(name: '김치', quantity: 5, hasBought: true, isSpicy: true);
    ShoppingItemModel _item2 = _item1.copywith(name: "Spaghetti", isSpicy: false, hasBought: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${_item1.name} ${_item1.quantity} ${_item1.hasBought} ${_item1.isSpicy}",
                textAlign: TextAlign.center,
              ),
              Text(
                "${_item2.name} ${_item2.quantity} ${_item2.hasBought} ${_item2.isSpicy}",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingItemModel {
  final String name; // 이름
  final int quantity; // 갯수
  final bool hasBought; // 구매 했는지
  final bool isSpicy; // 매운지;
  ShoppingItemModel(
      {required this.name,
      required this.quantity,
      required this.hasBought,
      required this.isSpicy});

  ShoppingItemModel copywith({String? name,
      int? quantity,
      bool? hasBought,
      bool? isSpicy}) {
        return ShoppingItemModel(name: name ?? this.name, quantity: quantity ?? this.quantity, hasBought: hasBought ?? this.hasBought, isSpicy: isSpicy ?? this.isSpicy);
    

  }

}