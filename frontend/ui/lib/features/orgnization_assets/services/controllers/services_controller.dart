part of service_management;

class ServiceManagementController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling services
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var services = <Service>[].obs;
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  // for authintication
  Rx<Profile?> currentProfile = Rx<Profile?>(null);

  @override
  void onInit() {
    assignCurrentProfile();
    fetchServices();
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
      projectName: "Service",
      releaseTime: DateTime.now(),
    );
  }

  void searchServices(String query) {
    if (query.isEmpty) {
      fetchServices();
    } else {
      var filteredServices = services.where((service) {
        return service.name.toLowerCase().contains(query.toLowerCase()) ||
            service.pk.toString().contains(query);
      }).toList();
      services.value = filteredServices;
    }
  }

  void fetchServices() async {
    isLoading.value = true;
    try {
      var fetchedServices = await _api.get('services');
      services.value = (fetchedServices as List)
          .map((json) => Service.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed! ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void addService(Service service) async {
    isLoading.value = true;
    try {
      var newService = await _api.post('services', service.toJson());
      services.add(Service.fromJson(newService));
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateService(Service service) async {
    isLoading.value = true;
    try {
      var updatedService =
          await _api.put('services/${service.pk}', service.toJson());
      int index = services.indexWhere((s) => s.pk == service.pk);
      if (index != -1) {
        services[index] = Service.fromJson(updatedService);
      }
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteService(int pk) async {
    isLoading.value = true;
    try {
      await _api.delete('services/$pk');
      services.removeWhere((service) => service.pk == pk);
    } catch (e) {
      Get.snackbar('Controller Error', 'Failed to delete service');
    } finally {
      isLoading.value = false;
    }
  }
}
