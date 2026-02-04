import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_config.dart';
import 'models/cart.dart';

class CartApi {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  CartApi({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? kApiBaseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        );

  Future<void> addItem({
    required int productId,
    int quantity = 1,
  }) async {
    final token = await _storage.read(key: 'jwt');
    final headers = token == null ? null : {'Authorization': 'Bearer $token'};
    final res = await _dio.post(
      '/cart/items/add',
      data: {
        'productId': productId,
        'quantity': quantity,
      },
      options: headers == null ? null : Options(headers: headers),
    );
    if (res.statusCode != 200) {
      throw StateError('Unexpected response for cart add');
    }
  }

  Future<Cart> getCart() async {
    final token = await _storage.read(key: 'jwt');
    final headers = token == null ? null : {'Authorization': 'Bearer $token'};
    final res = await _dio.get(
      '/cart',
      options: headers == null ? null : Options(headers: headers),
    );
    final data = res.data;
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    throw StateError('Unexpected response for cart');
  }

  Future<Cart> removeItem({required int productId}) async {
    final token = await _storage.read(key: 'jwt');
    final headers = token == null ? null : {'Authorization': 'Bearer $token'};
    final res = await _dio.delete(
      '/cart/items/$productId',
      options: headers == null ? null : Options(headers: headers),
    );
    final data = res.data;
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    throw StateError('Unexpected response for cart remove');
  }

  Future<Cart> setItemQuantity({
    required int productId,
    required int quantity,
  }) async {
    final token = await _storage.read(key: 'jwt');
    final headers = token == null ? null : {'Authorization': 'Bearer $token'};
    final res = await _dio.post(
      '/cart/items/set',
      data: {
        'productId': productId,
        'quantity': quantity,
      },
      options: headers == null ? null : Options(headers: headers),
    );
    final data = res.data;
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    throw StateError('Unexpected response for cart set');
  }
}
