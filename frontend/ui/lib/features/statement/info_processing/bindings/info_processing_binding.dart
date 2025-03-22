part of info_processing;

class InfoProcessingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfoProcessingController());
    Get.lazyPut(() => ProcessStatementFormController());
  }
}
