part of donor_management;

class DonorManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorManagementController());
  }
}
