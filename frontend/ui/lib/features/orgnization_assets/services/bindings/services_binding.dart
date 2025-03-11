part of service_management;

class ServiceManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceManagementController());
  }
}
