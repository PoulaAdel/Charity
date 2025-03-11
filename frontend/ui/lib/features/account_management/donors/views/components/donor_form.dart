part of donor_management;

class DonorForm extends StatelessWidget {
  final Donor? donor;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final DonorManagementController controller =
      Get.find<DonorManagementController>();

  DonorForm({Key? key, this.donor}) : super(key: key) {
    if (donor != null) {
      _nameController.text = donor!.name;
    }
  }

  void dispose() {
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donor == null ? 'Add Donor' : 'Edit Donor'),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (donor == null) {
                      controller.addDonor(Donor(name: _nameController.text));
                    } else {
                      controller.updateDonor(Donor(
                        pk: donor!.pk,
                        name: _nameController.text,
                      ));
                    }
                    Get.back();
                  }
                },
                child: Text(donor == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
