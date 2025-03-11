part of family_management;

class FamilyManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FamilyManagementController());
  }
}
