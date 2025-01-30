import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../config/routes/app_pages.dart';
import '../utils/services/authetication_services.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthenticationServices _authService = Get.find();

  bool userGranted = false;

  @override
  RouteSettings? redirect(String? route) {
    authinticate();
    if (userGranted && (route == Routes.login)) {
      return const RouteSettings(name: Routes.dashboard);
    } else {
      return const RouteSettings(name: Routes.login);
    }
  }

  Future<void> authinticate() async {
    userGranted = await _authService.isAuthenticated();
  }
}
