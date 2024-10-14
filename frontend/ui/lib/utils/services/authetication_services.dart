import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../database/models/app_models.dart';

class AuthService extends GetxService {
  final String baseUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String tokenKey = 'Authorization';

  AuthService(this.baseUrl);

  Future<bool> login(String username, String password) async {
    // Assuming there's no separate endpoint for CSRF token
    // (check backend configuration)
    final url = Uri.parse('$baseUrl/api-token-auth/');
    // final Authorization = await _getToken();
    // print(Authorization.toString());
    final response = await http.post(
      url,
      body: jsonEncode({'username': username, 'password': password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Check expected login success code
      final data = jsonDecode(response.body);
      final token = data['token'];
      await _saveToken(token);
      return true;
    } else {
      final message = response.body.isNotEmpty
          ? jsonDecode(response.body).toString()
          : 'Login failed.';
      Get.snackbar("${response.statusCode}", message);
      return false;
    }
  }

  Future<bool> register(User user) async {
    final url = Uri.parse('$baseUrl/users/register/');
    final token = await _getToken();
    final response = await http.post(
      url,
      body: jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
        tokenKey: token!.isEmpty ? "" : token.toString(),
      },
    ); // Encode the User object

    if (response.statusCode == 201) {
      // Assuming 201 Created for successful registration
      // Registration successful, handle further processing if needed
      Get.snackbar("Successful!", "Registered successfully!");
      return true;
    } else {
      Get.snackbar("Login failed!", '${response.statusCode}');
      throw Exception('Registration failed: ${response.statusCode}');
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
