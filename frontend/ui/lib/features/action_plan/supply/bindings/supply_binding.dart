part of supply;

class SupplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupplyController());
    Get.lazyPut(() => SupplyListController());
    Get.lazyPut(() => SupplyFormController());
  }
}
