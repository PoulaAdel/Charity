part of auth_register;

class RegisterController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling authenticaion
  final AuthService _authService = Get.find();

  //fields needed for handling login form
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPwd = TextEditingController();

  // the user who is currentlly active
  final UserHelper _userHelper = UserHelper(objectBox.store);
  User? currentUser;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    // if user is alread signedin signhim out
    if (_authService.isAuthenticated) {
      _authService.logout();
    }
    // initiate text fields
    controllerUsername.clear();
    controllerPhone.clear();
    controllerEmail.clear();
    controllerPwd.clear();

    super.onInit();
  }

  @override
  void onClose() {
    controllerUsername.dispose();
    controllerPhone.dispose();
    controllerEmail.dispose();
    controllerPwd.dispose();
    super.onClose();
  }

  bool usernameExists(String usernamInput) {
    return UserHelper(objectBox.store).checkUIDExists(usernamInput);
  }

  int registerNewUser() {
    int createdPK = 0;
    if (signupFormKey.currentState!.validate()) {
      createdPK = _userHelper.insertUser(
        User(
          username: controllerUsername.text,
          phone: controllerPhone.text,
          password: controllerPwd.text,
          email: controllerEmail.text,
          createdAt: DateTime.now(),
        ),
      );
    }
    return createdPK;
  }
}
