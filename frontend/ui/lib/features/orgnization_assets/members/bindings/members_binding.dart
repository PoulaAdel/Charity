part of member_management;

class MemeberManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberManagementController());
  }
}
