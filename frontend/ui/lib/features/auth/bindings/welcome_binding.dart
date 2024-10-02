part of welcome;

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
