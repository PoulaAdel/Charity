part of info_processing;

class ProcessStatementForm extends StatelessWidget {
  final String modelType; // "opinion", "suggestion"
  final ProcessStatementFormController controller;
  final int statementID;

  const ProcessStatementForm(
      {Key? key,
      required this.modelType,
      required this.controller,
      required this.statementID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.setData(statementID.toString(), modelType);
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
                    onSaved: (value) => () {},
                  ),
                  const SizedBox(height: 24),
                  Obx(() => Column(
                        children: [
                          Text(
                            'Last updated: ${controller.typeObject.value?.updatedAt ?? 'N/A'}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Created on: ${controller.typeObject.value?.createdAt ?? 'N/A'}',
                          ),
                        ],
                      )),
                  const SizedBox(height: 24),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  }),
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
      child: TextFormField(
        controller: controller.textController, // Ensure this is accessible
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onSaved: onSaved,
        validator: (value) =>
            value == null || value.isEmpty ? 'This field is required' : null,
        maxLines: 10, // Allow multiple lines
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
