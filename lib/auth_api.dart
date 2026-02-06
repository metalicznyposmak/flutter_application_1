import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApi {
  final Dio _dio;
  final _storage = const FlutterSecureStorage();

  AuthApi(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
        ));

  Future<String> login(String username, String password) async {
    final res = await _dio.post('/login', data: {
      'username': username,
      'password': password,
    });

    final token = res.data['access_token'] as String;
    await _storage.write(key: 'jwt', value: token);
    return token;
  }

  Future<void> register(String username, String password) async {
    await _dio.post('/register', data: {
      'username': username,
      'password': password,
    });
  }

  Future<String?> getToken() => _storage.read(key: 'jwt');
}
