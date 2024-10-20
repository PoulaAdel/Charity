part of donor;

class DonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonorController());
  }
}
