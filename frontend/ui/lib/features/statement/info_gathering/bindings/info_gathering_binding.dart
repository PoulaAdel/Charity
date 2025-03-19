part of info_gathering;

class InfoGatheringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfoGatheringController());
    Get.lazyPut(() => EditStatementFormController());
  }
}
