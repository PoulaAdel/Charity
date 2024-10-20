part of member;

class MemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberController());
  }
}
