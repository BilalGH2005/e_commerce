import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:e_commerce/shop/data/models/filtered_products_model.dart';
import 'package:e_commerce/shop/data/models/shop_metadata_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

import '../models/product_filters.dart';

abstract class ShopRepo {
  Future<AsyncResult<ShopMetadata, String>> getShopMetadata();

  Future<AsyncResult<FilteredProductsModel, String>> getFilteredProducts({
    required ProductFilters filters,
  });
}

class SupabaseShopRepo implements ShopRepo {
  @override
  Future<AsyncResult<ShopMetadata, String>> getShopMetadata() async {
    return await supabaseRpc(
      'get_shop_metadata',
      fromJson: ShopMetadata.fromJson,
    );
  }

  @override
  Future<AsyncResult<FilteredProductsModel, String>> getFilteredProducts({
    required ProductFilters filters,
  }) async {
    print('Filters:');
    print('  page: ${filters.page}');
    print('  searchQuery: ${filters.searchQuery}');
    print('  categoryId: ${filters.categoryId}');
    print('  colorId: ${filters.colorId}');
    print('  sizeId: ${filters.sizeId}');
    print(
        '  priceRange: ${filters.priceRange?.start} - ${filters.priceRange?.end}');

    return await supabaseRpc(
      'get_filtered_products',
      params: {
        'page': filters.page,
        if (filters.searchQuery != null) 'search_query': filters.searchQuery,
        if (filters.categoryId != null) 'category_id': filters.categoryId,
        if (filters.colorId != null) 'color_id': filters.colorId,
        if (filters.sizeId != null) 'size_id': filters.sizeId,
        if (filters.priceRange != null) ...{
          'min_price': filters.priceRange!.start,
          'max_price': filters.priceRange!.end,
        },
      },
      fromJson: FilteredProductsModel.fromJson,
      get: true,
    );
  }
}
