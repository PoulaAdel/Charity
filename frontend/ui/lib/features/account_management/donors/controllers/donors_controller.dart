part of donor_management;

class DonorManagementController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling donors
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();
  var donors = <Donor>[].obs;

  // for ui
  final ScrollController scrollController = ScrollController();
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  // for authentication
  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  // for handling form
  final RxInt id = 0.obs;
  final RxString name = ''.obs;

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

  void logoutDonor() {
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
      projectName: "DonorManagement",
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

  // for handling data CRUD
  void searchDonors(String query) {
    if (query.isEmpty) {
      fetchDonors();
    } else {
      var filteredDonors = donors.where((donor) {
        return donor.name.toLowerCase().contains(query.toLowerCase()) ||
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

  Future<void> addDonor(Donor donor) async {
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

  Future<void> updateDonor(Donor donor) async {
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

  Future<void> deleteDonor(int pk) async {
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

  // for handling form
  void setDonor(Donor? donor) {
    if (donor != null) {
      id.value = donor.pk!;
      name.value = donor.name;
    } else {
      id.value = 0;
      name.value = '';
    }
  }

  Future<void> submitForm(Donor? existingDonor) async {
    try {
      if (existingDonor == null) {
        final donorData = Donor(
          name: name.value,
        );
        await addDonor(donorData);
        Get.snackbar('Success', 'Donor added successfully');
      } else {
        final donorData = Donor(
          pk: id.value,
          name: name.value,
        );
        await updateDonor(donorData);
        Get.snackbar('Success', 'Donor updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
