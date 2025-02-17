import 'dart:convert';

import 'package:charity/features/auth/views/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../database/models/app_models.dart';
import 'local_secure_storage_services.dart';

class AuthenticationServices extends GetxService {
  final String baseUrl;
  final LocalSecureStorageServices _localSecureStorage = Get.find();

  AuthenticationServices(this.baseUrl);

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api-token-auth/');
    final response = await http.post(
      url,
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      //** Get user from backend */
      // await _localSecureStorage.secureStorage.write(
      //   key: 'USER',
      //   value: User(
      //     username: username,
      //     password: password,
      //   ).toJson().toString(),
      // );
      await LocalSecureStorageServices.setToken(token);
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
    final response = await http.post(
      url,
      body: jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      Get.offAll(LoginScreen());
      return true;
    } else {
      final message = response.body.isNotEmpty
          ? jsonDecode(response.body).toString()
          : 'Registration failed.';
      Get.snackbar("${response.statusCode}", message);
      return false;
    }
  }

  Future<void> logout() async {
    // await _localSecureStorage.secureStorage.delete(key: 'USER');
    await LocalSecureStorageServices.deleteToken();
  }

  Future<bool> isAuthenticated() async {
    final token = await LocalSecureStorageServices.getToken();
    return token != null && token.isNotEmpty;
  }
}
