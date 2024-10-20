part of service;

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceController());
  }
}
