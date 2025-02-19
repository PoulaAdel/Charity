part of donor;

class DonorController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling donors
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var donors = <Donor>[].obs;
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  // for authintication
  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  @override
  void onInit() {
    assignCurrentProfile();
    fetchDonors();
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
      projectName: "Donor",
      releaseTime: DateTime.now(),
    );
  }

  void searchDonors(String query) {
    if (query.isEmpty) {
      fetchDonors();
    } else {
      var filteredDonors = donors.where((donor) {
        return donor.name
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            donor.pk.toString().contains(query);
      }).toList();
      donors.value = filteredDonors;
    }
  }

  void fetchDonors() async {
    isLoading.value = true;
    try {
      var fetchedDonors = await _api.get('donors');
      donors.value = (fetchedDonors as List)
          .map((json) => Donor.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void addDonor(Donor donor) async {
    isLoading.value = true;
    try {
      var newDonor = await _api.post('donors', donor.toJson());
      donors.add(Donor.fromJson(newDonor));
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateDonor(Donor donor) async {
    isLoading.value = true;
    try {
      var updatedDonor = await _api.put('donors/${donor.pk}', donor.toJson());
      int index = donors.indexWhere((s) => s.pk == donor.pk);
      if (index != -1) {
        donors[index] = Donor.fromJson(updatedDonor);
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteDonor(int pk) async {
    isLoading.value = true;
    try {
      await _api.delete('donors/$pk');
      donors.removeWhere((donor) => donor.pk == pk);
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed to delete donor');
    } finally {
      isLoading.value = false;
    }
  }
}
