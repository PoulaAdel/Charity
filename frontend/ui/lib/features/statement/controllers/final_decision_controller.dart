part of final_decision;

class FinalDecisionController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling authenticaion
  final AuthService _authService = Get.find();

  final ScrollController scrollController = ScrollController();
  final _localSecureStorage = Get.find<LocalSecureStorage>();

  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    // // get current user from secure storage
    // Future.delayed(Duration.zero, () async {
    //   //your async 'await' codes goes here
    //   //..
    // });
    assignCurrentUser();
    super.onInit();
  }

  void assignCurrentUser() async {
    User? secureData = await _localSecureStorage.getUser;
    currentUser.value = secureData;
    update();
  }

  void logoutUser() {
    _authService.logout();
    Get.offAllNamed(Routes.login);
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void scrollToTop() {
    double start = 0;
    // scrollController.jumpTo(start);
    scrollController.animateTo(
      start,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  SidebarHeaderData getSelectedProject() {
    return SidebarHeaderData(
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "FinalDecision",
      releaseTime: DateTime.now(),
    );
  }

  // List<ImageProvider> getMember() {
  //   return const [
  //     AssetImage(ImageRasterPath.avatar1),
  //   ];
  // }
}
