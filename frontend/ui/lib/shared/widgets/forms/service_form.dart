import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../database/models/app_models.dart';
import '../../../features/orgnization_assets/views/screens/service_screen.dart';

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
                      ));
                    } else {
                      controller.updateService(Service(
                        pk: service!.pk,
                        name: _nameController.text,
                        description: _descriptionController.text,
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
