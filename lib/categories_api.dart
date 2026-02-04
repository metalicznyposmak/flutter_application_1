import 'package:dio/dio.dart';

import 'api_config.dart';
import 'models/category.dart';

class CategoriesApi {
  final Dio _dio;

  CategoriesApi({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? kApiBaseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        );

  Future<List<Category>> listCategories() async {
    final res = await _dio.get('/categories');
    final data = res.data;
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(Category.fromJson)
          .toList();
    }
    throw StateError('Unexpected response for categories');
  }
}
