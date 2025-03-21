part of info_processing;

class EditStatementFormController extends GetxController {
  final RestApiServices _api = Get.find();
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  final statementID = ''.obs;
  final modelType = ''.obs;
  final typeContent = ''.obs;
  final isLoading = false.obs;
  final typeObject = Rx<dynamic>(null);

  void setData(String id, String type) {
    statementID.value = id;
    modelType.value = type;
    checkExistingContent();
  }

  List parseObjectList(List<dynamic> list) {
    var dynamicTypeList = [];
    switch (modelType.value) {
      case 'opinion':
        dynamicTypeList = list.map((item) => Opinion.fromJson(item)).toList();
        break;
      case 'suggestion':
        dynamicTypeList =
            list.map((item) => Suggestion.fromJson(item)).toList();
        break;
      default:
        dynamicTypeList = [];
    }
    return dynamicTypeList;
  }

  Future<void> checkExistingContent() async {
    if (statementID.isNotEmpty && modelType.isNotEmpty) {
      try {
        isLoading.value = true;
        var response = await _api.get('${modelType.value}s', queryParameters: {
          'statement': statementID.value.toString(),
        });
        if (response.isNotEmpty) {
          typeObject.value = parseObjectList(response).first;
          typeContent.value = typeObject.value.content;
          textController.text = typeContent.value;
          update(); // Notify listeners of state changes
        } else {
          typeContent.value = '';
          textController.text = ''; // Clear TextEditingController
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch content: $e',
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> submitForm() async {
    if (typeObject.value != null) {
      isLoading.value = true;
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save();
        typeContent.value =
            textController.text; // Sync with TextEditingController
        try {
          await _api.patch('${modelType.value}s/${typeObject.value.pk}',
              {'content': typeContent.value});
          Get.snackbar(
              'Success', '${modelType.value.capitalizeFirst} model updated!',
              snackPosition: SnackPosition.BOTTOM);
        } catch (e) {
          Get.snackbar('Error', 'Failed to submit form: $e',
              snackPosition: SnackPosition.BOTTOM);
        } finally {
          isLoading.value = false;
        }
      }
    } else {
      Get.snackbar('Error', 'Failed to submit form: Invalid data',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
