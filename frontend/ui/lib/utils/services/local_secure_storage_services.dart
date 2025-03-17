import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../database/models/app_models.dart';
import '../../shared/widgets/profile.dart';

class LocalSecureStorageServices extends GetxService {
  static const _secureStorage = FlutterSecureStorage();
  static const _tokenKey = 'Authorization';

  FlutterSecureStorage get secureStorage => _secureStorage;

  /// *
  /// for Authenticated user info
  /// *

  Future<Profile?> get getProfile async {
    Profile? currentProfile;
    String? data = await _secureStorage.read(key: 'USER');
    if (data != null && data.isNotEmpty) {
      currentProfile = Profile.fromJson(jsonDecode(data));
    }
    return currentProfile;
  }

  static setProfile(Profile profile) async {
    await _secureStorage.write(
      key: 'USER',
      value: jsonEncode(profile.toJson()),
    );
  }

  /// *
  /// for authintication purbose
  /// *

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  /// *
  /// for family and statement management
  /// *

  Future<Family?> getFamily() async {
    String? data = await _secureStorage.read(key: 'FAMILY');
    if (data != null && data.isNotEmpty) {
      return Family.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<void> saveFamily(Family family) async {
    await _secureStorage.write(
      key: 'FAMILY',
      value: jsonEncode(family.toJson()),
    );
  }

  Future<Statement?> getStatement() async {
    String? data = await _secureStorage.read(key: 'STATEMENT');
    if (data != null && data.isNotEmpty) {
      return Statement.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<void> saveStatement(Statement statement) async {
    await _secureStorage.write(
      key: 'STATEMENT',
      value: jsonEncode(statement.toJson()),
    );
  }

  Future<void> deleteFamily() async {
    await _secureStorage.delete(key: 'FAMILY');
  }

  Future<void> deleteStatement() async {
    await _secureStorage.delete(key: 'STATEMENT');
  }
}
