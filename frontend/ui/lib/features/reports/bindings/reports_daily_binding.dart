part of reports_daily;

class ReportsDailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsDailyController());
  }
}
