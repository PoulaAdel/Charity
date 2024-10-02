import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../database/models/app_models.dart';

class LocalSecureStorage extends GetxService {
  late FlutterSecureStorage _secureStorage;

  FlutterSecureStorage get secureStorage => _secureStorage;

  Future<User?> get getUser async {
    User? currentUser;
    String? data = await _secureStorage.read(key: 'KEY_USER');
    if (data != null && data.isNotEmpty) {
      currentUser = User.fromJson(jsonDecode(data));
    }
    return currentUser;
  }

  LocalSecureStorage init() {
    _secureStorage = const FlutterSecureStorage();
    return this;
  }
}
