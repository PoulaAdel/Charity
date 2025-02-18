part of reports_products;

class ReportsProductsController extends GetxController {
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

  Profile getProfil() {
    return Profile(
      id: currentProfile.value != null ? currentProfile.value!.id : 0,
      photo: const AssetImage(ImageRasterPath.avatar1),
      username: currentProfile.value != null
          ? currentProfile.value!.username.toString()
          : "Loading..",
      email: currentProfile.value != null
          ? currentProfile.value!.email.toString()
          : "Loading..",
      role: currentProfile.value != null ? currentProfile.value!.role : 0,
    );
  }

  SidebarHeaderData getSelectedProject() {
    return SidebarHeaderData(
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Products Reports",
      releaseTime: DateTime.now(),
    );
  }

  List<ImageProvider> getMember() {
    return const [
      AssetImage(ImageRasterPath.avatar1),
      AssetImage(ImageRasterPath.avatar2),
      AssetImage(ImageRasterPath.avatar3),
      AssetImage(ImageRasterPath.avatar4),
      AssetImage(ImageRasterPath.avatar5),
      AssetImage(ImageRasterPath.avatar6),
    ];
  }

  List<ChattingCardData> getChatting() {
    return const [
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar6),
        isOnline: true,
        name: "Samantha",
        lastMessage: "i added my new tasks",
        isRead: false,
        totalUnread: 100,
      ),
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar3),
        isOnline: false,
        name: "John",
        lastMessage: "well done john",
        isRead: true,
        totalUnread: 0,
      ),
      ChattingCardData(
        image: AssetImage(ImageRasterPath.avatar4),
        isOnline: true,
        name: "Alexander Purwoto",
        lastMessage: "we'll have a meeting at 9AM",
        isRead: false,
        totalUnread: 1,
      ),
    ];
  }
}
