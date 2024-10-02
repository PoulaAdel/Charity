part of reports_custom;

class ReportsCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsCustomController());
  }
}
