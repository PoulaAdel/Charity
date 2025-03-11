part of donation_management;

class DonationManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonationManagementController());
  }
}
