part of donation;

class DonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonationController());
  }
}
