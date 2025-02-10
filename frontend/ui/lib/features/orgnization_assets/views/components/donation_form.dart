part of donation;

class DonationForm extends StatelessWidget {
  final Donation? donation;
  final _formKey = GlobalKey<FormState>();
  final _donorController = TextEditingController();
  final _typeController = TextEditingController();
  final _notesController = TextEditingController();
  final _amountController = TextEditingController();
  final _createdAtController = TextEditingController();
  final _updatedAtController = TextEditingController();
  final DonationController controller = Get.find<DonationController>();

  DonationForm({Key? key, this.donation}) : super(key: key) {
    if (donation != null) {
      _donorController.text = donation!.donor.toString();
      _typeController.text = donation!.type.toString();
      _notesController.text = donation!.notes ?? '';
      _amountController.text = donation!.amount.toString();
      _createdAtController.text = donation!.createdAt.toIso8601String();
      _updatedAtController.text = donation!.updatedAt?.toIso8601String() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donation == null ? 'Add Donation' : 'Edit Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _donorController,
                  decoration: const InputDecoration(labelText: 'Donor'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a donor ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'Type'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _createdAtController,
                  decoration: const InputDecoration(labelText: 'Created At'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a creation date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _updatedAtController,
                  decoration: const InputDecoration(labelText: 'Updated At'),
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (donation == null) {
                        controller.addDonation(Donation(
                          donor: int.parse(_donorController.text),
                          type: int.parse(_typeController.text),
                          notes: _notesController.text,
                          amount: double.parse(_amountController.text),
                          createdAt: DateTime.parse(_createdAtController.text),
                          updatedAt: _updatedAtController.text.isNotEmpty
                              ? DateTime.parse(_updatedAtController.text)
                              : null,
                        ));
                      } else {
                        controller.updateDonation(Donation(
                          pk: donation!.pk,
                          donor: int.parse(_donorController.text),
                          type: int.parse(_typeController.text),
                          notes: _notesController.text,
                          amount: double.parse(_amountController.text),
                          createdAt: DateTime.parse(_createdAtController.text),
                          updatedAt: _updatedAtController.text.isNotEmpty
                              ? DateTime.parse(_updatedAtController.text)
                              : null,
                        ));
                      }
                      Get.back();
                    }
                  },
                  child: Text(donation == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
