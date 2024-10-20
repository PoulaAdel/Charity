part of family;

class FamilyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FamilyController());
  }
}
