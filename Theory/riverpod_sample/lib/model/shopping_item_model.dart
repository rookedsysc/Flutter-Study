import 'package:flutter/material.dart';

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

  ShoppingItemModel copyWith({
    String? name,
    int? quantity,
    bool? hasBought,
    bool? isSpicy,
  }) {
    return ShoppingItemModel(
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        hasBought: hasBought ?? this.hasBought,
        isSpicy: isSpicy ?? this.isSpicy);
  }
}
