part of info_gathering;

class InfoGatheringController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthenticationServices _authService = Get.find();
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final RestApiServices _api = Get.find();
  final ScrollController scrollController = ScrollController();

  Rx<Profile?> currentProfile = Rx<Profile?>(null);
  Rx<Family?> selectedFamily = Rx<Family?>(null);
  Rx<Statement?> selectedStatement = Rx<Statement?>(null);
  var families = <Family>[].obs;
  var statements = <Statement>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    assignCurrentProfile();
    assignFamilyAndStatement();
    fetchFamilies();
    fetchStatements(null);
  }

  // Assign the current profile from local secure storage
  void assignCurrentProfile() async {
    Profile? secureData = await _localSecureStorage.getProfile;
    currentProfile.value = secureData;
    update();
  }

  // Check and load family and statement from local storage
  void assignFamilyAndStatement() async {
    Family? storedFamily = await _localSecureStorage.getFamily();
    if (storedFamily != null) {
      selectedFamily.value = storedFamily;
    }

    Statement? storedStatement = await _localSecureStorage.getStatement();
    if (storedStatement != null) {
      selectedStatement.value = storedStatement;
    }
  }

  // Logout the user and navigate to login screen
  void logoutUser() {
    _authService.logout();
    Get.offAllNamed(Routes.login);
  }

  // Get the profile data
  Profile getProfil() {
    return Profile(
      id: currentProfile.value?.id ?? 0,
      photo: const AssetImage(ImageRasterPath.avatar1),
      username: currentProfile.value?.username.toString() ?? "Loading..",
      email: currentProfile.value?.email.toString() ?? "Loading..",
      role: currentProfile.value?.role ?? 0,
    );
  }

  // Get the list of member images
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

  // Get the list of chatting card data
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

  // Open the drawer
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  // Scroll to the top of the page
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  // Get the selected project data for the sidebar
  SidebarHeaderData getSelectedProject() {
    return SidebarHeaderData(
      projectImage: const AssetImage(ImageRasterPath.logo3),
      projectName: "Gathering Information",
      releaseTime: DateTime.now(),
    );
  }

  // Fetch the list of families from the API
  Future<void> fetchFamilies() async {
    try {
      var fetchedFamilies = await _api.get('families');
      families.value = (fetchedFamilies as List)
          .map((json) => Family.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch families: ${e.toString()}');
    }
  }

  // Fetch the list of statements from the API
  Future<void> fetchStatements(int? familyID) async {
    if (familyID != null) {
      try {
        var fetchedStatements = await _api.get(
          'statements',
          queryParameters: {'family': familyID.toString()},
        );
        statements.value = (fetchedStatements as List)
            .map((json) => Statement.fromJson(json as Map<String, dynamic>))
            .toList();
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch statements: ${e.toString()}');
      }
    } else {
      statements.clear();
    }
  }

  // Choose a family from the list
  Future<Family?> chooseFamily(BuildContext context) async {
    RxList<Family> filteredFamilies = families;

    Family? selectedFamily = await Get.dialog<Family>(
      AlertDialog(
        title: Row(
          children: [
            const Text('Choose Family'),
            const SizedBox(width: 10),
            const Divider(),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Filter by name or ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) async {
                  isLoading.value = true;
                  if (value.isNotEmpty) {
                    filteredFamilies.value = families.where((family) {
                      return family.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          family.pk.toString().contains(value);
                    }).toList();
                  } else {
                    await fetchFamilies();
                  }
                  isLoading.value = false;
                },
              ),
            ),
          ],
        ),
        content: Obx(
          () {
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (filteredFamilies.isEmpty) {
              return const Center(
                child: Text('No families found'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredFamilies.map((family) {
                    return TextButton(
                      onPressed: () => Get.back(result: family),
                      child: Text(
                        '# ${family.pk} : ${family.name}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );

    if (selectedFamily != null) {
      fetchStatements(selectedFamily.pk);
      return families.firstWhere((family) => family.pk == selectedFamily.pk);
    }
    return null;
  }

  // Choose a statement from the list
  Future<Statement?> chooseStatement(
      BuildContext context, Family family) async {
    RxList<Statement> filteredStatements = statements;

    Statement? selectedStatement = await Get.dialog<Statement>(
      AlertDialog(
        title: Row(
          children: [
            const Text('Choose Statement'),
            const SizedBox(width: 10),
            const Divider(),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Filter by ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  isLoading.value = true;
                  if (value.isNotEmpty) {
                    filteredStatements.value = statements.where((statement) {
                      return statement.pk.toString().contains(value);
                    }).toList();
                  } else {
                    filteredStatements.value = statements;
                  }
                  isLoading.value = false;
                },
              ),
            ),
          ],
        ),
        content: Obx(
          () {
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (filteredStatements.isEmpty) {
              return const Center(
                child: Text('No statements found'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredStatements.map((statement) {
                    return TextButton(
                      onPressed: () => Get.back(result: statement),
                      child: Text(
                        'Statement ${statement.pk}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (selectedStatement != null) {
      return statements
          .firstWhere((statement) => statement.pk == selectedStatement.pk);
    }
    return null;
  }

  Future<void> resetStatement() async {
    // Reset the selected statement
    selectedStatement.value = null;
    await _localSecureStorage.deleteStatement();
  }

  Future<void> resetFamily() async {
    // Reset the selected family
    selectedFamily.value = null;
    await _localSecureStorage.deleteFamily();
  }

  Future<void> clearData() async {
    await resetFamily();
    await resetStatement();
    update();
  }
}
