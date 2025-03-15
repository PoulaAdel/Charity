part of 'app_pages.dart';

/// used to switch pages
class Routes {
  // Authintications Routes
  static const welcome = _Paths.welcome;
  static const login = _Paths.login;
  static const register = _Paths.register;
  // Home Page Route
  static const dashboard = _Paths.dashboard;
  // Users Management
  static const donors = _Paths.donors;
  static const members = _Paths.members;
  // Orgnization Elements
  static const services = _Paths.services;
  static const donations = _Paths.donations;
  static const families = _Paths.families;
  // Statement Managemnt
  static const infogathering = _Paths.infogathering;
  static const infoprocessing = _Paths.infoprocessing;
  static const finaldecision = _Paths.finaldecision;
  // Action Plan
  static const supplies = _Paths.supplies;
  static const checks = _Paths.checks;
  // Generate Reports
  static const weeklyReport = _Paths.weeklyReport;
  static const monthlyReport = _Paths.monthlyReport;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';

  static const dashboard = '/dashboard';

  static const donors = '/account_management/donors';
  static const members = '/account_management/members';

  static const services = '/orgnization_assets/services';
  static const donations = '/orgnization_assets/donations';
  static const families = '/orgnization_assets/families';

  static const infogathering = '/statement/info_gathering';
  static const infoprocessing = '/statement/info_processing';
  static const finaldecision = '/statement/final_decision';

  static const supplies = '/action_plan/supplies';
  static const checks = '/action_plan/checks';

  static const weeklyReport = '/reports/weekly_report';
  static const monthlyReport = '/reports/monthly_report';
}
