import 'package:get/get.dart';

import '../../middleware/auth_middleware.dart';

import '../../features/auth/views/screens/login_screen.dart';
import '../../features/auth/views/screens/register_screen.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';

import '../../features/reports/views/screens/reports_daily_screen.dart';
import '../../features/reports/views/screens/reports_monthly_screen.dart';

import '../../features/welcome/views/screens/welcome_screen.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.welcome,
      page: () => WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.reportsDaily,
      page: () => ReportsDailyScreen(),
      binding: ReportsDailyBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.reportsMonthly,
      page: () => ReportsMonthlyScreen(),
      binding: ReportsMonthlyBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
