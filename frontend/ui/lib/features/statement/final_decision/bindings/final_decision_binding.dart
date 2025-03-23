part of final_decision;

class FinalDecisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FinalDecisionController());
    Get.lazyPut(() => DecisionStatementFormController());
  }
}
