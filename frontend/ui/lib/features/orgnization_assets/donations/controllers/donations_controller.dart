part of donation_management;

class DonationManagementController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling donations
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();
  var donations = <Donation>[].obs;

  // for ui
  final ScrollController scrollController = ScrollController();
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

  List<TaskCardData> getAllTask() {
    return [
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: 2,
        totalComments: 50,
        type: TaskType.todo,
        totalContributors: 30,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar1),
          AssetImage(ImageRasterPath.avatar2),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
        ],
      ),
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: -1,
        totalComments: 50,
        totalContributors: 34,
        type: TaskType.inProgress,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar6),
          AssetImage(ImageRasterPath.avatar7),
          AssetImage(ImageRasterPath.avatar8),
        ],
      ),
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: 1,
        totalComments: 50,
        totalContributors: 34,
        type: TaskType.done,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
          AssetImage(ImageRasterPath.avatar2),
        ],
      ),
    ];
  }

  SidebarHeaderData getSelectedProject() {
    return SidebarHeaderData(
      projectImage: const AssetImage(ImageRasterPath.logo3),
      projectName: "DonationManagement",
      releaseTime: DateTime.now(),
    );
  }

  List<ProjectCardData> getActiveProject() {
    return [
      ProjectCardData(
        percent: .3,
        projectImage: const AssetImage(ImageRasterPath.logo2),
        projectName: "Taxi Online",
        releaseTime: DateTime.now().add(const Duration(days: 130)),
      ),
      ProjectCardData(
        percent: .5,
        projectImage: const AssetImage(ImageRasterPath.logo3),
        projectName: "E-Movies Mobile",
        releaseTime: DateTime.now().add(const Duration(days: 140)),
      ),
      ProjectCardData(
        percent: .8,
        projectImage: const AssetImage(ImageRasterPath.logo4),
        projectName: "Video Converter App",
        releaseTime: DateTime.now().add(const Duration(days: 100)),
      ),
    ];
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

  Future<void> fetchDonations() async {
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

  Future<void> addDonation(Donation donation) async {
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

  Future<void> updateDonation(Donation donation) async {
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

  Future<void> deleteDonation(int pk) async {
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
