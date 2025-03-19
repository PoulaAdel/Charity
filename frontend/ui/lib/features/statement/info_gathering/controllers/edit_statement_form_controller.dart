part of info_gathering;

class EditStatementFormController extends GetxController {
  final RestApiServices _api = Get.find<RestApiServices>();
  final InfoGatheringController _infoGatheringController =
      Get.find<InfoGatheringController>();
  final formKey = GlobalKey<FormState>();
  final typeContent = ''.obs;
  final modelType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(modelType, (_) => checkExistingContent());
  }

  void setModelType(String type) {
    modelType.value = type;
  }

  Future<void> checkExistingContent() async {
    var response = await _api.get('${modelType.value}s', queryParameters: {
      'statement':
          _infoGatheringController.selectedStatement.value!.pk.toString()
    });
    if (response.isNotEmpty) {
      typeContent.value = response.first['content'];
    }
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      // TODO: Save formData to the database for the specific model type
      Get.snackbar(
          'Success', '${modelType.value.capitalizeFirst} model updated!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
