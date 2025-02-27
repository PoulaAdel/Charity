part of member;

class MemberController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling members
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var members = <Member>[].obs;
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  // for authentication
  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  // for handling form
  final Rxn<File> nidFile = Rxn<File>();
  final Rxn<File> faceImgFile = Rxn<File>();
  final RxInt id = 0.obs;
  final RxString name = ''.obs;
  final RxInt family = 0.obs;
  final RxInt relation = 0.obs;
  final RxString contact = ''.obs;
  final RxInt age = 0.obs;
  final RxString education = ''.obs;
  final RxDouble income = 0.0.obs;
  final RxString health = ''.obs;

  @override
  void onInit() {
    assignCurrentProfile();
    fetchMembers();
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
      projectName: "Member",
      releaseTime: DateTime.now(),
    );
  }

  // for handling data CRUD
  void searchMembers(String query) {
    if (query.isEmpty) {
      fetchMembers();
    } else {
      var filteredMembers = members.where((member) {
        return member.name.toLowerCase().contains(query.toLowerCase()) ||
            member.pk.toString().contains(query);
      }).toList();
      members.value = filteredMembers;
    }
  }

  void fetchMembers() async {
    isLoading.value = true;
    try {
      var fetchedMembers = await _api.get('members');
      members.value = (fetchedMembers as List)
          .map((json) => Member.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addMember(
      Member member, File? nidFile, File? faceImgFile) async {
    isLoading.value = true;
    try {
      var response = await _api.postMultipart(
        'members/',
        fields: member
            .toJson()
            .map((key, value) => MapEntry(key, value.toString())),
        files: {
          'nid': nidFile,
          'face_img': faceImgFile,
        },
      );
      if (response.statusCode == 201) {
        fetchMembers();
        Get.snackbar('Success', 'Member added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add member');
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateMember(
      Member member, File? nidFile, File? faceImgFile) async {
    isLoading.value = true;
    try {
      var response = await _api.putMultipart(
        'members/${member.pk}/',
        fields: member
            .toJson()
            .map((key, value) => MapEntry(key, value.toString())),
        files: {
          'nid': nidFile,
          'face_img': faceImgFile,
        },
      );
      if (response.statusCode == 200) {
        fetchMembers();
        Get.snackbar('Success', 'Member updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update member');
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteMember(int pk) async {
    isLoading.value = true;
    try {
      await _api.delete('members/$pk');
      members.removeWhere((member) => member.pk == pk);
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed to delete member');
    } finally {
      isLoading.value = false;
    }
  }

  // for handling form
  void setMember(Member? member) {
    if (member != null) {
      id.value = member.pk!;
      name.value = member.name;
      family.value = member.family;
      relation.value = member.relation;
      contact.value = member.contact ?? '';
      age.value = member.age;
      education.value = member.education ?? '';
      income.value = member.income;
      health.value = member.health ?? '';
      nidFile.value = null; // Reset file fields
      faceImgFile.value = null; // Reset file fields
    } else {
      name.value = '';
      family.value = 0;
      relation.value = 0;
      contact.value = '';
      age.value = 0;
      education.value = '';
      income.value = 0.0;
      health.value = '';
      nidFile.value = null;
      faceImgFile.value = null;
    }
  }

  Future<void> pickNidFile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        nidFile.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking NID file: $e');
    }
  }

  Future<void> pickFaceImgFile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        faceImgFile.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking face image: $e');
    }
  }

  Future<void> submitForm(Member? existingMember) async {
    try {
      if (existingMember == null) {
        final memberData = Member(
          name: name.value,
          family: family.value,
          relation: relation.value,
          contact: contact.value,
          nid: nidFile.value?.path ?? '',
          faceImg: faceImgFile.value?.path,
          age: age.value,
          education: education.value,
          income: income.value,
          health: health.value,
        );
        await addMember(memberData, nidFile.value, faceImgFile.value);
        Get.snackbar('Success', 'Member added successfully');
      } else {
        final memberData = Member(
          pk: id.value,
          name: name.value,
          family: family.value,
          relation: relation.value,
          contact: contact.value,
          nid: nidFile.value?.path ?? '',
          faceImg: faceImgFile.value?.path,
          age: age.value,
          education: education.value,
          income: income.value,
          health: health.value,
        );
        await updateMember(memberData, nidFile.value, faceImgFile.value);
        Get.snackbar('Success', 'Member updated successfully');
      }
      Get.back(); // Return to previous screen after submission
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
