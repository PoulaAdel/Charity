part of check;

class CheckController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling authenticaion
  final AuthenticationServices _authService = Get.find();
  final LocalSecureStorageServices _localSecureStorage = Get.find();

  final ScrollController scrollController = ScrollController();

  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  @override
  void onInit() {
    // // get current user from secure storage
    // Future.delayed(Duration.zero, () async {
    //   //your async 'await' codes goes here
    //   //..
    // });
    assignCurrentProfile();
    super.onInit();
  }

  void assignCurrentProfile() async {
    Profile? secureData = await _localSecureStorage.getProfile;
    currentProfile.value = secureData;
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
      projectName: "Check",
      releaseTime: DateTime.now(),
    );
  }

  // List<ImageProvider> getMember() {
  //   return const [
  //     AssetImage(ImageRasterPath.avatar1),
  //   ];
  // }
}
