import 'package:dio/dio.dart';
import 'api_config.dart';
import 'models/product.dart';
import 'package:flutter/foundation.dart';

class ProductsApi {
  final Dio _dio;

  ProductsApi({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? kApiBaseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        );

  Future<List<Product>> listProducts({
    required int categoryId,
    bool onlyActive = true,
  }) async {
    final res = await _dio.get(
      '/products',
      queryParameters: {
        'categoryId': categoryId,
        'onlyActive': onlyActive,
      },
    );
    final data = res.data;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(Product.fromJson)
          .toList();
    }
    throw StateError('Unexpected response for products');
  }

  Future<Product> getProduct({required int productId}) async {
    final res = await _dio.get('/products/$productId');
    final data = res.data;
    if (data is Map<String, dynamic>) {
      return Product.fromJson(data);
    }
    throw StateError('Unexpected response for product $productId');
  }
}
