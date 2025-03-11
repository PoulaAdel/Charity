part of user_management;

class UserManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserManagementController());
  }
}
