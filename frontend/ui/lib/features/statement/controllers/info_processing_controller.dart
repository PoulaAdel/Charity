part of info_processing;

class InfoProcessingController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling authenticaion
  final AuthenticationServices _authService =
      Get.find<AuthenticationServices>();

  final ScrollController scrollController = ScrollController();
  final LocalSecureStorageServices _localSecureStorage =
      Get.find<LocalSecureStorageServices>();

  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  @override
  void onInit() {
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
      projectName: "InfoProcessing",
      releaseTime: DateTime.now(),
    );
  }

  // List<ImageProvider> getMember() {
  //   return const [
  //     AssetImage(ImageRasterPath.avatar1),
  //   ];
  // }
}
