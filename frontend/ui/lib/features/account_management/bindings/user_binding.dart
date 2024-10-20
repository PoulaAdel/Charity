part of user;

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
