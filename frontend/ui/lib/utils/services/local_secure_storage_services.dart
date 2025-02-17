import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../database/models/app_models.dart';

class LocalSecureStorageServices extends GetxService {
  static const _secureStorage = FlutterSecureStorage();
  static const _tokenKey = 'Authorization';

  FlutterSecureStorage get secureStorage => _secureStorage;

  Future<User?> get getUser async {
    User? currentUser;
    String? data = await _secureStorage.read(key: 'USER');
    if (data != null && data.isNotEmpty) {
      currentUser = User.fromJson(jsonDecode(data));
    }
    return currentUser;
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
