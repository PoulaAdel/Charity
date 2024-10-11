part of auth_login;

class LoginController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // Access AuthService
  final AuthService _authService = Get.find<AuthService>();
  //fields needed for handling login form
  final loginFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  //fields needed for handling request
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    // initiate text fields
    _usernameController.clear();
    _passwordController.clear();
    super.onInit();
  }

  @override
  void onClose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      _isLoading.value = true;

      final username = _usernameController.text;
      final password = _passwordController.text;

      final result =
          await _authService.login(username, password); // Use AuthService

      if (result) {
        // Successfully logged in, save token or handle further processing
        _isLoading.value = false;
        Get.offNamed('/homepage'); // Replace with your desired route
      } else {
        _isLoading.value = false;
        _errorMessage.value = 'Login failed. Please check your credentials.';
        update();
      }
    } catch (e) {
      _isLoading.value = false;
      _errorMessage.value = 'An error occurred. Please try again later.';
      update();
    }
  }

  void clearFields() {
    _usernameController.clear();
    _passwordController.clear();
    _errorMessage.value = '';
    update();
  }
}
