part of check;

class CheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckController());
  }
}
