part of reports_monthly;

class ReportsMonthlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsMonthlyController());
  }
}
