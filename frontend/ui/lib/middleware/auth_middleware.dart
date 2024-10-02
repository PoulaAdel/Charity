import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../config/routes/app_pages.dart';
import '../utils/services/authetication_services.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthService _authService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (!_authService.isAuthenticated) {
      return const RouteSettings(name: Routes.login);
    }
    if (_authService.isAuthenticated && (route == Routes.login)) {
      return const RouteSettings(name: Routes.dashboard);
    }
    return null;
  }
}
