import 'dart:convert';

import '../../features/auth/views/screens/login_screen.dart';
import '../../shared/widgets/profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../database/models/app_models.dart';
import 'local_secure_storage_services.dart';

class AuthenticationServices extends GetxService {
  final String baseUrl;

  AuthenticationServices(this.baseUrl);

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api-token-auth/');
    final response = await http.post(
      url,
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Save token to secure storage
      final data = jsonDecode(response.body);
      final token = data['token'];
      await LocalSecureStorageServices.setToken(token);
      // Get user profile data
      await updateProfileData();
      // Redirect to dashboard
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

  Future<void> updateProfileData() async {
    final url = Uri.parse('$baseUrl/api/authenticated_user_info/');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await LocalSecureStorageServices.getToken()}',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final profile = Profile.fromJson(data);
      await LocalSecureStorageServices.setProfile(profile);
    } else {
      final message = response.body.isNotEmpty
          ? jsonDecode(response.body).toString()
          : 'Failed to get profile data.';
      Get.snackbar("${response.statusCode}", message);
    }
  }
}
