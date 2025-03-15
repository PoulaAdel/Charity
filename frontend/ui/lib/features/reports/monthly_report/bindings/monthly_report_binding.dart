part of monthly_report;

class MonthlyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MonthlyReportController());
  }
}
