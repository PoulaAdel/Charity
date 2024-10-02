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
  static const users = _Paths.users;
  static const donors = _Paths.donors;
  // Orgnization Elements
  static const services = _Paths.services;
  static const donations = _Paths.donations;
  static const families = _Paths.families;
  static const persons = _Paths.persons;
  // Info Gathering
  static const statements = _Paths.statements;
  static const socials = _Paths.socials;
  static const spirituals = _Paths.spirituals;
  static const residentials = _Paths.residentials;
  static const economicals = _Paths.economicals;
  // Info Processing
  static const opinions = _Paths.opinions;
  static const suggestions = _Paths.suggestions;
  // Final Judgement
  static const judgements = _Paths.judgements;
  // Action Plan
  static const supplies = _Paths.supplies;
  static const checks = _Paths.checks;
  // Generate Reports
  static const reportsDaily = _Paths.reportsDaily;
  static const reportsMonthly = _Paths.reportsMonthly;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const welcome = '/welcome';

  static const login = '/login';
  static const register = '/register';

  static const dashboard = '/dashboard';

  static const users = '/users';
  static const donors = '/donors';

  static const services = '/services';
  static const donations = '/donations';
  static const families = '/families';
  static const persons = '/persons';

  static const statements = '/statements';
  static const socials = '/socials';
  static const spirituals = '/spirituals';
  static const residentials = '/residentials';
  static const economicals = '/economicals';

  static const opinions = '/opinions';
  static const suggestions = '/suggestions';

  static const judgements = '/judgements';

  static const supplies = '/supplies';
  static const checks = '/checks';

  static const reportsDaily = '/reports/daily';
  static const reportsMonthly = '/reports/monthly';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
