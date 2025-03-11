part of info_gathering;

class InfoGatheringController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling authentication
  final AuthenticationServices _authService = Get.find();
  final LocalSecureStorageServices _localSecureStorage = Get.find();

  final ScrollController scrollController = ScrollController();

  Rx<Profile?> currentProfile = Rx<Profile?>(null);
  RxString selectedFamily = ''.obs;
  RxString selectedStatement = ''.obs;

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
      projectImage: const AssetImage(ImageRasterPath.logo3),
      projectName: "Gathering Information",
      releaseTime: DateTime.now(),
    );
  }

  void onNewStatementPressed(BuildContext context) async {
    final family = await chooseFamily(context);
    if (family != null) {
      selectedFamily.value = family;
      _showStatementOptions(context, family, null);
    }
  }

  void onExistingStatementPressed(BuildContext context) async {
    final family = await chooseFamily(context);
    if (family != null) {
      selectedFamily.value = family;
      final statement = await chooseStatement(context, family);
      if (statement != null) {
        selectedStatement.value = statement;
        _showStatementOptions(context, family, statement);
      }
    }
  }

  Future<String?> chooseFamily(BuildContext context) async {
    // Replace with your logic to choose a family
    return await Get.dialog<String>(
      AlertDialog(
        title: const Text('Choose Family'),
        content: const Text('Family selection logic goes here'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: 'Family 1'),
            child: const Text('Family 1'),
          ),
          TextButton(
            onPressed: () => Get.back(result: 'Family 2'),
            child: const Text('Family 2'),
          ),
        ],
      ),
    );
  }

  Future<String?> chooseStatement(BuildContext context, String family) async {
    // Replace with your logic to choose a statement
    return await Get.dialog<String>(
      AlertDialog(
        title: const Text('Choose Statement'),
        content: const Text('Statement selection logic goes here'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: 'Statement 1'),
            child: const Text('Statement 1'),
          ),
          TextButton(
            onPressed: () => Get.back(result: 'Statement 2'),
            child: const Text('Statement 2'),
          ),
        ],
      ),
    );
  }

  void _showStatementOptions(
      BuildContext context, String family, String? statement) {
    Get.dialog(
      AlertDialog(
        title: const Text('Edit Statement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () =>
                  _editStatement(context, family, statement, 'Spiritual'),
              child: const Text('Edit Spiritual Statement'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _editStatement(context, family, statement, 'Economical'),
              child: const Text('Edit Economical Statement'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _editStatement(context, family, statement, 'Residential'),
              child: const Text('Edit Residential Statement'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _editStatement(context, family, statement, 'Social'),
              child: const Text('Edit Social Statement'),
            ),
          ],
        ),
      ),
    );
  }

  void _editStatement(
      BuildContext context, String family, String? statement, String type) {
    // Replace with your logic to edit the statement
    Get.back(); // Close the dialog
  }
}
