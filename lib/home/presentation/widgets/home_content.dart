import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:e_commerce/home/presentation/widgets/new_products_carousel.dart';
import 'package:e_commerce/home/presentation/widgets/products_grid.dart';
import 'package:e_commerce/shop/data/models/filtered_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeContent extends StatelessWidget {
  final List<Product> products;

  const HomeContent({super.key, required this.products});

  @override
  Widget build(BuildContext context) => SmartRefresher(
        controller: RefreshController(),
        onRefresh: () async => await context.read<HomeCubit>().initializeHome(),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: NewProductsCarousel(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: ProductsGrid(products: products),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: () async =>
                    await context.read<HomeCubit>().loadMoreProducts(),
                child: context.read<HomeCubit>().isLoading
                    ? CircularProgressIndicator()
                    : Text(localization(context).seeMore),
              ),
            )
          ],
        ),
      );
}
