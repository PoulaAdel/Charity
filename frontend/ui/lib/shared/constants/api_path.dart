part of app_constants;

/// all endpoint api
class ApiPath {
  // Example :
  // static const _baseURL = "http://172.0.0.1:8000/";
  // static const products = "$_baseURL/products/";

  static const String _baseURL =
      "http://localhost:8000"; // Environment variable placeholder

  static String baseURL() => _baseURL;

  static String users(String id) => Uri.parse('$_baseURL/users/$id').toString();
  static String usersList() => Uri.parse('$_baseURL/users/').toString();

  // Similar patterns for other endpoints
  static String services(String id) =>
      Uri.parse('$_baseURL/services/$id').toString();
  static String servicesList() => Uri.parse('$_baseURL/services/').toString();
  static String donations(String id) =>
      Uri.parse('$_baseURL/donations/$id').toString();
  static String donationsList() => Uri.parse('$_baseURL/donations/').toString();
  static String families(String id) =>
      Uri.parse('$_baseURL/families/$id').toString();
  static String familiesList() => Uri.parse('$_baseURL/families/').toString();
  static String persons(String id) =>
      Uri.parse('$_baseURL/persons/$id').toString();
  static String personsList() => Uri.parse('$_baseURL/persons/').toString();
  static String statements(String id) =>
      Uri.parse('$_baseURL/statements/$id').toString();
  static String statementsList() =>
      Uri.parse('$_baseURL/statements/').toString();
  static String socials(String id) =>
      Uri.parse('$_baseURL/socials/$id').toString();
  static String socialsList() => Uri.parse('$_baseURL/socials/').toString();
  static String spirituals(String id) =>
      Uri.parse('$_baseURL/spirituals/$id').toString();
  static String spiritualsList() =>
      Uri.parse('$_baseURL/spirituals/').toString();
  static String residentials(String id) =>
      Uri.parse('$_baseURL/residentials/$id').toString();
  static String residentialsList() =>
      Uri.parse('$_baseURL/residentials/').toString();
  static String economicals(String id) =>
      Uri.parse('$_baseURL/economicals/$id').toString();
  static String economicalsList() =>
      Uri.parse('$_baseURL/economicals/').toString();
  static String opinions(String id) =>
      Uri.parse('$_baseURL/opinions/$id').toString();
  static String opinionsList() => Uri.parse('$_baseURL/opinions/').toString();
  static String suggestions(String id) =>
      Uri.parse('$_baseURL/suggestions/$id').toString();
  static String suggestionsList() =>
      Uri.parse('$_baseURL/suggestions/').toString();
  static String judgements(String id) =>
      Uri.parse('$_baseURL/judgements/$id').toString();
  static String judgementsList() =>
      Uri.parse('$_baseURL/judgements/').toString();
  static String supplies(String id) =>
      Uri.parse('$_baseURL/supplies/$id').toString();
  static String suppliesList() => Uri.parse('$_baseURL/supplies/').toString();
  static String checks(String id) =>
      Uri.parse('$_baseURL/checks/$id').toString();
  static String checksList() => Uri.parse('$_baseURL/checks/').toString();
}
