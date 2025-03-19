part of info_gathering;

class EditStatementForm extends StatelessWidget {
  final String modelType; // "spiritual", "economical", "social", "residential"
  EditStatementForm({Key? key, required this.modelType}) : super(key: key);

  final EditStatementFormController controller =
      Get.find<EditStatementFormController>();

  @override
  Widget build(BuildContext context) {
    controller.setModelType(modelType);
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
                    label: 'Content',
                    onSaved: (value) => controller.typeContent.value = value!,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => controller.submitForm(),
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
    return Card(
      child: Obx(() => TextFormField(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            initialValue: controller.typeContent.value.isNotEmpty
                ? controller.typeContent.value
                : null,
            onSaved: onSaved,
            validator: (value) => value == null || value.isEmpty
                ? 'This field is required'
                : null,
            maxLines: 10, // Allow multiple lines
            keyboardType: TextInputType.multiline,
          )),
    );
  }
}
