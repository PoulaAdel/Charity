import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../database/models/app_models.dart';
import '../../features/auth/views/screens/login_screen.dart';
import '../../shared/widgets/profile.dart';
import 'local_secure_storage_services.dart';

class AuthenticationServices extends GetxService {
  final String baseUrl;
  final Dio dio;

  AuthenticationServices(this.baseUrl)
      : dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> login(String username, String password) async {
    const url = '/api-token-auth/';
    try {
      final response = await dio.post(
        url,
        data: {'username': username, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final data = response.data;
      final token = data['token'];
      await LocalSecureStorageServices.setToken(token);
      await updateProfileData();
      return true;
    } catch (e) {
      final message = e is DioException && e.response != null
          ? e.response!.data.toString()
          : 'Login failed.';
      Get.snackbar(
          "${e is DioException ? e.response?.statusCode : 'Error'}", message);
      return false;
    }
  }

  Future<bool> register(User user) async {
    const url = '/users/register/';
    try {
      await dio.post(
        url,
        data: user.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      Get.offAll(LoginScreen());
      return true;
    } catch (e) {
      final message = e is DioException && e.response != null
          ? e.response!.data.toString()
          : 'Registration failed.';
      Get.snackbar(
          "${e is DioException ? e.response?.statusCode : 'Error'}", message);
      return false;
    }
  }

  Future<void> logout() async {
    await LocalSecureStorageServices.deleteToken();
  }

  Future<bool> isAuthenticated() async {
    final token = await LocalSecureStorageServices.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> updateProfileData() async {
    const url = '/api/authenticated_user_info/';
    try {
      final response = await dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Token ${await LocalSecureStorageServices.getToken()}',
        }),
      );

      final data = response.data;
      final profile = Profile.fromJson(data);
      await LocalSecureStorageServices.setProfile(profile);
    } catch (e) {
      final message = e is DioException && e.response != null
          ? e.response!.data.toString()
          : 'Failed to get profile data.';
      Get.snackbar(
          "${e is DioException ? e.response?.statusCode : 'Error'}", message);
    }
  }
}
