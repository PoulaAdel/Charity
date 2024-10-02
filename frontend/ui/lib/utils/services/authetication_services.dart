import 'package:get/get.dart';
import '../../utils/services/local_secure_storage_services.dart';

import '../../database/models/app_models.dart';

class AuthService extends GetxService {
  bool _isAuthenticated = false;
  final UserHelper _userHelper = UserHelper(objectBox.store);
  final LocalSecureStorage _localSecureStorage = Get.find();

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String uid, String pwd) async {
    // Perform login logic
    // ...
    User? found = _userHelper.getUserOf(uid, pwd);
    if (found != null) {
      await _localSecureStorage.secureStorage.write(
        key: "KEY_USER",
        value: found.toString(),
      );
      // Set isAuthenticated to true
      _isAuthenticated = true;
    }
  }

  Future<void> logout() async {
    // Perform logout logic
    // ...
    await _localSecureStorage.secureStorage.delete(
      key: "KEY_USER",
    );
    // Set isAuthenticated to false
    _isAuthenticated = false;
  }
}
