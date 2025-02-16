part of service;

class ServiceForm extends StatelessWidget {
  final Service? service;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ServiceController controller = Get.find<ServiceController>();

  ServiceForm({Key? key, this.service}) : super(key: key) {
    if (service != null) {
      _nameController.text = service!.name;
      _descriptionController.text = service!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service == null ? 'Add Service' : 'Edit Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (service == null) {
                      controller.addService(Service(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        createdAt: DateTime.now(),
                      ));
                    } else {
                      controller.updateService(Service(
                        pk: service!.pk,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        createdAt: service!.createdAt,
                        updatedAt: DateTime.now(),
                      ));
                    }
                    Get.back();
                  }
                },
                child: Text(service == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
