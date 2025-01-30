part of auth_login;

class LoginController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // Access AuthService
  final AuthenticationServices _authService = Get.find();
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
    _isLoading.value = true;

    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      bool success = await _authService.login(username, password);
      if (success) {
        _isLoading.value = false;
        Get.snackbar("Success!", "Login successful");
        Get.offAll(() => DashboardScreen(), binding: DashboardBinding());
      } else {
        _isLoading.value = false;
        _errorMessage.value = 'Login failed. Please check your credentials.';
        Get.snackbar("Failed!", _errorMessage.value);
        update();
      }
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Error", e.toString());
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
