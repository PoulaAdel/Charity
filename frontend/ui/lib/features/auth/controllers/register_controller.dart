part of auth_register;

class RegisterController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling authenticaion
  final AuthenticationServices _authService = Get.find();

  //fields needed for handling login form
  final signupFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //fields to handle request
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  // the user who is currentlly active
  User? currentUser;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    // if user is alread signedin signhim out
    _authService.logout();
    // initiate text fields
    _usernameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();

    super.onInit();
  }

  @override
  void onClose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    try {
      _isLoading.value = true;

      final username = _usernameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final password = _passwordController.text;

      // Create a User object with the provided data
      final user = User(
        username: username,
        role: 0,
        email: email,
        phone: phone,
        password: password,
        createdAt: DateTime.now(),
      );

      // Call the registration method in your AuthService
      final result = await _authService.register(user);

      if (result) {
        // Successfully registered, handle further processing
        _isLoading.value = false;
        Get.offNamed('/login'); // Navigate to login screen
      } else {
        _isLoading.value = false;
        _errorMessage.value = 'Registration failed. Please check your input.';
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
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _errorMessage.value = '';
    update();
  }
}
