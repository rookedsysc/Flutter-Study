import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/component/pagination_list_view.dart';
import 'package:lv2_actual/product/component/product_card.dart';
import 'package:lv2_actual/product/model/product_model.dart';
import 'package:lv2_actual/product/provider/product_provider.dart';



class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(context, index, model) =>
          ProductCard.fromProductModel(model: model),
    );
  }
}
