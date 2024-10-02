part of reports_products;

class ReportsProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsProductsController());
  }
}
