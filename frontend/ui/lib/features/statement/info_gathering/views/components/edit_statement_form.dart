part of info_gathering;

class EditStatementFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formData = <String, dynamic>{}.obs;

  void submitForm(String modelType) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      // TODO: Save formData to the database for the specific model type
      Get.snackbar('Success', '$modelType model updated!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class EditStatementForm extends StatelessWidget {
  final String modelType; // "spiritual", "economical", "social", "residential"
  EditStatementForm({Key? key, required this.modelType}) : super(key: key);

  final EditStatementFormController controller =
      Get.put(EditStatementFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${modelType.capitalizeFirst} Statement'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Update ${modelType.capitalizeFirst} Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Field 1',
                    onSaved: (value) => controller.formData['field1'] = value,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Field 2',
                    onSaved: (value) => controller.formData['field2'] = value,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Field 3',
                    onSaved: (value) => controller.formData['field3'] = value,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        controller.submitForm(modelType.capitalizeFirst!),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onSaved: onSaved,
      validator: (value) =>
          value == null || value.isEmpty ? 'This field is required' : null,
    );
  }
}
