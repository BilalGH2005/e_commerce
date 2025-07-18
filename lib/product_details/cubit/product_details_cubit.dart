import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/product_details/data/repos/product_details_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shop/data/models/filtered_products_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final String productId;
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsCubit(
      {required this.productId, required this.productDetailsRepo})
      : super(ProductInitial()) {
    getProductDetails(productId: productId);
  }

  final PageController imagesController = PageController();

  AsyncValue<Product, String> product = AsyncValue.initial();

  Future<void> getProductDetails({
    required String productId,
  }) async {
    product = AsyncValue.loading();

    final result = await productDetailsRepo.getProduct(productId);

    if (result.isData) {
      product = AsyncValue.data(data: result.data!);
      emit(ProductDetailsDataChangedState());
    } else {
      product = AsyncValue.error(error: result.error!);
      emit(ProductDetailsDataChangedState());
    }
  }

  Future<void> goToPreviousImage() async => await imagesController.previousPage(
        duration: 1.s,
        curve: Curves.decelerate,
      );

  Future<void> goToNextImage() async => await imagesController.nextPage(
        duration: 1.s,
        curve: Curves.decelerate,
      );

  @override
  Future<void> close() {
    imagesController.dispose();
    return super.close();
  }
}
