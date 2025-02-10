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

  // for authintication
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    assignCurrentUser();
    fetchMembers();
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
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Member",
      releaseTime: DateTime.now(),
    );
  }

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
      print(e.toString());
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void addMember(Member member) async {
    isLoading.value = true;
    try {
      var newMember = await _api.post('members', member.toJson());
      members.add(Member.fromJson(newMember));
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateMember(Member member) async {
    isLoading.value = true;
    try {
      var updatedMember =
          await _api.put('members/${member.pk}', member.toJson());
      int index = members.indexWhere((s) => s.pk == member.pk);
      if (index != -1) {
        members[index] = Member.fromJson(updatedMember);
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
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
}
