part of service;

class ServiceController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // for handling authenticaion
  final AuthService _authService = Get.find();

  final ScrollController scrollController = ScrollController();
  final _localSecureStorage = Get.find<LocalSecureStorage>();

  Rx<User?> currentUser = Rx<User?>(null);

  var services = <Service>[].obs;

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

  void fetchServices() {
    ServiceProvider().fetchServices().then((value) {
      services.assignAll(ServiceProvider().services);
    });
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

  void addService(Service service) {
    ServiceProvider().addService(service).then((value) {
      services.add(service);
    });
  }

  void updateService(Service service) {
    ServiceProvider().updateService(service).then((value) {
      final index = services.indexWhere((s) => s.pk == service.pk);
      if (index != -1) {
        services[index] = service;
      }
    });
  }

  void deleteService(int pk) {
    ServiceProvider().deleteService(pk).then((value) {
      services.removeWhere((service) => service.pk == pk);
    });
  }

  SidebarHeaderData getSelectedProject() {
    return SidebarHeaderData(
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Service",
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
}
