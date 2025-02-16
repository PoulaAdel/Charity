part of family;

class FamilyController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling families
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var families = <Family>[].obs;
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  // for authintication
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    assignCurrentUser();
    fetchFamilies();
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

  Profile getProfil() {
    return Profile(
      photo: const AssetImage(ImageRasterPath.avatar1),
      name: currentUser.value != null
          ? currentUser.value!.username.toString()
          : "Loading..",
      email: currentUser.value != null
          ? currentUser.value!.email.toString()
          : "Loading..",
    );
  }

  List<ImageProvider> getFamily() {
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
      projectName: "Family",
      releaseTime: DateTime.now(),
    );
  }

  void searchFamilies(String query) {
    if (query.isEmpty) {
      fetchFamilies();
    } else {
      var filteredFamilies = families.where((family) {
        return family.name.toLowerCase().contains(query.toLowerCase()) ||
            family.pk.toString().contains(query);
      }).toList();
      families.value = filteredFamilies;
    }
  }

  void fetchFamilies() async {
    isLoading.value = true;
    try {
      var fetchedFamilies = await _api.get('families');
      families.value = (fetchedFamilies as List)
          .map((json) => Family.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void addFamily(Family family) async {
    isLoading.value = true;
    try {
      var newFamily = await _api.post('families', family.toJson());
      families.add(Family.fromJson(newFamily));
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateFamily(Family family) async {
    isLoading.value = true;
    try {
      var updatedFamily =
          await _api.put('families/${family.pk}', family.toJson());
      int index = families.indexWhere((s) => s.pk == family.pk);
      if (index != -1) {
        families[index] = Family.fromJson(updatedFamily);
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteFamily(int pk) async {
    isLoading.value = true;
    try {
      await _api.delete('families/$pk');
      families.removeWhere((family) => family.pk == pk);
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed to delete family');
    } finally {
      isLoading.value = false;
    }
  }
}
