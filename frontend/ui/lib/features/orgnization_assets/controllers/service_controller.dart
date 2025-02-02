part of service;

class ServiceController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // for handling services
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final AuthenticationServices _authService = Get.find();
  final RestApiServices _api = Get.find();

  // for ui
  final ScrollController scrollController = ScrollController();
  var services = <Service>[].obs;
  var isLoading = false.obs;

  // for authintication
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    assignCurrentUser();
    fetchServices();
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
      projectName: "Service",
      releaseTime: DateTime.now(),
    );
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
