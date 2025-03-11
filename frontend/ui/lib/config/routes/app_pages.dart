import 'package:charity/features/orgnization_assets/services/views/screens/services_screen.dart';
import 'package:get/get.dart';

import '../../features/account_management/donors/views/screens/donors_screen.dart';
import '../../features/account_management/users/views/screens/users_screen.dart';

import '../../features/action_plan/views/screens/check_screen.dart';
import '../../features/action_plan/views/screens/supply_screen.dart';

import '../../features/auth/views/screens/login_screen.dart';
import '../../features/auth/views/screens/register_screen.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';

import '../../features/orgnization_assets/donations/views/screens/donations_screen.dart';
import '../../features/orgnization_assets/families/views/screens/families_screen.dart';
import '../../features/orgnization_assets/members/views/screens/members_screen.dart';

import '../../features/statement/final_decision/views/screens/final_decision_screen.dart';
import '../../features/statement/info_gathering/views/screens/info_gathering_screen.dart';
import '../../features/statement/info_processing/views/screens/info_processing_screen.dart';
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
      page: () => UserManagementScreen(),
      binding: UserManagementBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.donors,
      page: () => DonorManagementScreen(),
      binding: DonorManagementBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: _Paths.services,
      page: () => ServiceManagementScreen(),
      binding: ServiceManagementBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.donations,
      page: () => DonationManagementScreen(),
      binding: DonationManagementBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.families,
      page: () => FamilyManagementScreen(),
      binding: FamilyManagementBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.members,
      page: () => MemberManagementScreen(),
      binding: MemeberManagementBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // GetPage(
    //   name: _Paths.statement,
    //   page: () => StatementScreen(),
    //   binding: StatementBinding(),
    //   // middlewares: [AuthMiddleware()],
    // ),
    GetPage(
      name: _Paths.infogathering,
      page: () => InfoGatheringScreen(),
      binding: InfoGatheringBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.infoprocessing,
      page: () => InfoProcessingScreen(),
      binding: InfoProcessingBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.finaldecision,
      page: () => FinalDecisionScreen(),
      binding: FinalDecisionBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: _Paths.supplies,
      page: () => SupplyScreen(),
      binding: SupplyBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.checks,
      page: () => CheckScreen(),
      binding: CheckBinding(),
      middlewares: [AuthMiddleware()],
    ),
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
