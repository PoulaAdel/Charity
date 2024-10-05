import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  final String baseUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String tokenKey = 'authToken';

  AuthService(this.baseUrl);

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api-auth/');
    final response = await http.post(url,
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await _saveToken(token);
      return true;
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }

  Future<void> logout() async {
    await _removeToken();
  }

  Future<bool> isAuthenticated() async {
    final token = await _getToken();
    return token != null;
  }

  Future<String?> _getToken() async {
    return await _storage.read(key: tokenKey);
  }

  Future<void> _saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  Future<void> _removeToken() async {
    await _storage.delete(key: tokenKey);
  }
}
