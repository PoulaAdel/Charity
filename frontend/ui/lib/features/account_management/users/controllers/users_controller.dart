part of user_management;

class UserManagementController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling users
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();
  var users = <User>[].obs;
  // for ui
  final ScrollController scrollController = ScrollController();
  var isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  // for authentication
  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  // for handling form
  final RxInt id = 0.obs;
  final RxString username = ''.obs;
  final RxString phone = ''.obs;
  final RxString email = ''.obs;
  final RxInt role = 0.obs;
  final RxString password = ''.obs;
  final RxString password2 = ''.obs;
  final Rxn<File> profileImage = Rxn<File>();

  @override
  void onInit() {
    assignCurrentProfile();
    fetchUsers();
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
      projectName: "UserManagement",
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
  void searchUsers(String query) {
    if (query.isEmpty) {
      fetchUsers();
    } else {
      var filteredUsers = users.where((user) {
        return user.username.toLowerCase().contains(query.toLowerCase()) ||
            user.pk.toString().contains(query);
      }).toList();
      users.value = filteredUsers;
    }
  }

  void fetchUsers() async {
    isLoading.value = true;
    try {
      var fetchedUsers = await _api.get('users');
      users.value = (fetchedUsers as List)
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser(User user, File? profileImage) async {
    isLoading.value = true;
    try {
      var response = await _api.postMultipart(
        'users/',
        fields:
            user.toJson().map((key, value) => MapEntry(key, value.toString())),
        files: {
          if (profileImage != null) 'profile_image': profileImage,
        },
      );
      if (response.statusCode == 201) {
        fetchUsers();
        Get.snackbar('Success', 'User added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add user');
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    }
  }

  Future<void> updateUser(User user, File? profileImage) async {
    isLoading.value = true;
    try {
      var response = await _api.patchMultipart(
        'users/${user.pk}',
        fields:
            user.toJson().map((key, value) => MapEntry(key, value.toString())),
        files: {
          if (profileImage != null) 'profile_image': profileImage,
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Get.snackbar('Success ${response.statusCode}',
            'User updated successfully  ${response.body}');
        fetchUsers();
      } else {
        Get.snackbar('Error ${response.statusCode}',
            'Failed to update user. ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    }
  }

  void deleteUser(int pk) async {
    isLoading.value = true;
    try {
      await _api.delete('users/$pk');
      users.removeWhere((user) => user.pk == pk);
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed to delete user');
    } finally {
      isLoading.value = false;
    }
  }

  // for handling form
  void setUser(User? user) {
    if (user != null) {
      id.value = user.pk!;
      username.value = user.username;
      phone.value = user.phone ?? '';
      email.value = user.email ?? '';
      role.value = user.role;
      profileImage.value =
          user.profileImage != null ? File(user.profileImage!) : null;
    } else {
      id.value = 0;
      username.value = '';
      phone.value = '';
      email.value = '';
      role.value = 0;
      profileImage.value = null;
    }
    update();
  }

  Future<void> pickFaceImgFile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking face image: $e');
    }
  }

  Future<void> submitForm(User? existingUser) async {
    try {
      if (existingUser == null) {
        final userData = User(
          username: username.value,
          phone: phone.value,
          email: email.value,
          role: role.value,
          password: password.value,
          profileImage: profileImage.value?.path,
        );
        await addUser(userData, profileImage.value);
      } else {
        final userData = User(
          pk: id.value,
          username: username.value,
          phone: phone.value,
          email: email.value,
          role: role.value,
          password: existingUser.password,
          profileImage: profileImage.value?.path,
        );
        await updateUser(userData, profileImage.value);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
