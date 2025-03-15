part of supply;

class SupplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupplyController());
  }
}
