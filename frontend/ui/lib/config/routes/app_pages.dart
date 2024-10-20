import 'package:get/get.dart';

import '../../features/account_management/views/screens/donor_screen.dart';
import '../../features/account_management/views/screens/user_screen.dart';
import '../../features/auth/views/screens/login_screen.dart';
import '../../features/auth/views/screens/register_screen.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';

import '../../features/orgnization_assets/views/screens/donation_screen.dart';
import '../../features/orgnization_assets/views/screens/family_screen.dart';
import '../../features/orgnization_assets/views/screens/member_screen.dart';
import '../../features/orgnization_assets/views/screens/service_screen.dart';

import '../../features/welcome/views/screens/welcome_screen.dart';

import '../../middleware/auth_middleware.dart';

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
      name: _Paths.users,
      page: () => UserScreen(),
      binding: UserBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.donors,
      page: () => DonorScreen(),
      binding: DonorBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.services,
      page: () => ServiceScreen(),
      binding: ServiceBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.donations,
      page: () => DonationScreen(),
      binding: DonationBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.families,
      page: () => FamilyScreen(),
      binding: FamilyBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.members,
      page: () => MemberScreen(),
      binding: MemberBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // GetPage(
    //   name: _Paths.statement,
    //   page: () => StatementScreen(),
    //   binding: StatementBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.statement,
    //   page: () => InfoGatheringScreen(),
    //   binding: InfoGatheringBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.statement,
    //   page: () => InfoProcessingScreen(),
    //   binding: InfoProcessingBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.statement,
    //   page: () => FinalDecisionScreen(),
    //   binding: FinalDecisionBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.supply,
    //   page: () => SupplyScreen(),
    //   binding: SupplyBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.check,
    //   page: () => CheckScreen(),
    //   binding: CheckBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.reportsDaily,
    //   page: () => ReportsDailyScreen(),
    //   binding: ReportsDailyBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: _Paths.reportsMonthly,
    //   page: () => ReportsMonthlyScreen(),
    //   binding: ReportsMonthlyBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
  ];
}
