import 'package:e_commerce/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../cubit/home_cubit.dart';
import '../models/product.dart';

class ProductsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const ProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: RefreshController(),
      onRefresh: () async {
        await context.read<HomeCubit>().fetchProducts();
      },
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 164,
          mainAxisExtent: 239,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 164 / 239,
        ),
        itemBuilder: (context, index) =>
            ProductCard(product: Product.fromProducts(products[index])),
      ),
    );
  }
}
