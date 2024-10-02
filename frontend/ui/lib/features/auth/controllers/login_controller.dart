part of auth_login;

class LoginController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling authenticaion
  final AuthService _authService = Get.find();

  //fields needed for handling login form
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController controllerID = TextEditingController();
  TextEditingController controllerPWD = TextEditingController();

  // the user who is currentlly active
  User? currentUser;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    // initiate text fields
    controllerID.clear();
    controllerPWD.clear();
    super.onInit();
  }

  @override
  void onClose() {
    controllerID.dispose();
    controllerPWD.dispose();
    super.onClose();
  }

  bool usernameExists(String usernamInput) {
    return UserHelper(objectBox.store).checkUIDExists(usernamInput);
  }

  Future<void> loginCheck() async {
    // check if credentials are exitis and right
    await _authService.login(
      controllerID.text.toString().trim(),
      controllerPWD.text.toString(),
    );

    if (_authService.isAuthenticated) {
      Get.offAllNamed(Routes.dashboard);
    } else {
      Get.snackbar("Wrong Password!", "Please recheck you password!");
    }
  }
}
