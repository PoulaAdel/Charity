part of user;

class UserController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling users
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var users = <User>[].obs;
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

  // for UI
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
      projectName: "User",
      releaseTime: DateTime.now(),
    );
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
          'face_img': profileImage,
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(User user, File? profileImage) async {
    isLoading.value = true;
    try {
      var response = await _api.putMultipart(
        'users/${user.pk}',
        fields:
            user.toJson().map((key, value) => MapEntry(key, value.toString())),
        files: {
          'face_img': profileImage,
        },
      );
      if (response.statusCode == 200) {
        fetchUsers();
        Get.snackbar('Success', 'User updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update user');
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
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
      password.value = '';
      password2.value = '';
      profileImage.value =
          user.profileImage != null ? File(user.profileImage!) : null;
    } else {
      id.value = 0;
      username.value = '';
      phone.value = '';
      email.value = '';
      role.value = 0;
      password.value = '';
      password2.value = '';
      profileImage.value = null;
    }
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
        Get.snackbar('Success', 'User added successfully');
      } else {
        final userData = User(
          pk: id.value,
          username: username.value,
          phone: phone.value,
          email: email.value,
          role: role.value,
          password: password.value,
          profileImage: profileImage.value?.path,
        );
        await updateUser(userData, profileImage.value);
        Get.snackbar('Success', 'User updated successfully');
      }
      Get.back(); // Return to previous screen after submission
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
