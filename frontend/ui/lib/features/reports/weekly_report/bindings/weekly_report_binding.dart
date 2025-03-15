part of weekly_report;

class WeeklyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeeklyReportController());
  }
}
