part of donation;

class DonationController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling donations
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var donations = <Donation>[].obs;
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  // for authintication
  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  @override
  void onInit() {
    assignCurrentProfile();
    fetchDonations();
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
      projectName: "Donation",
      releaseTime: DateTime.now(),
    );
  }

  void searchDonations(String query) {
    if (query.isEmpty) {
      fetchDonations();
    } else {
      var filteredDonations = donations.where((donation) {
        return donation.donor
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            donation.pk.toString().contains(query);
      }).toList();
      donations.value = filteredDonations;
    }
  }

  void fetchDonations() async {
    isLoading.value = true;
    try {
      var fetchedDonations = await _api.get('donations');
      donations.value = (fetchedDonations as List)
          .map((json) => Donation.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void addDonation(Donation donation) async {
    isLoading.value = true;
    try {
      var newDonation = await _api.post('donations', donation.toJson());
      donations.add(Donation.fromJson(newDonation));
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateDonation(Donation donation) async {
    isLoading.value = true;
    try {
      var updatedDonation =
          await _api.put('donations/${donation.pk}', donation.toJson());
      int index = donations.indexWhere((s) => s.pk == donation.pk);
      if (index != -1) {
        donations[index] = Donation.fromJson(updatedDonation);
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteDonation(int pk) async {
    isLoading.value = true;
    try {
      await _api.delete('donations/$pk');
      donations.removeWhere((donation) => donation.pk == pk);
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed to delete donation');
    } finally {
      isLoading.value = false;
    }
  }
}
