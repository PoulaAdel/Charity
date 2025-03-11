part of donation_management;

class DonationForm extends StatelessWidget {
  final Donation? donation;
  final _formKey = GlobalKey<FormState>();
  final _donorController = TextEditingController();
  final _typeController = TextEditingController();
  final _notesController = TextEditingController();
  final _amountController = TextEditingController();
  final DonationManagementController controller =
      Get.find<DonationManagementController>();

  DonationForm({Key? key, this.donation}) : super(key: key) {
    if (donation != null) {
      _donorController.text = donation!.donor.toString();
      _typeController.text = donation!.type.toString();
      _notesController.text = donation!.notes ?? '';
      _amountController.text = donation!.amount.toString();
    }
  }

  void dispose() {
    _donorController.dispose();
    _typeController.dispose();
    _notesController.dispose();
    _amountController.dispose();
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (donation == null) {
                        controller.addDonation(Donation(
                          donor: int.parse(_donorController.text),
                          type: int.parse(_typeController.text),
                          notes: _notesController.text,
                          amount: double.parse(_amountController.text),
                          createdAt: DateTime.now(),
                        ));
                      } else {
                        controller.updateDonation(Donation(
                          pk: donation!.pk,
                          donor: int.parse(_donorController.text),
                          type: int.parse(_typeController.text),
                          notes: _notesController.text,
                          amount: double.parse(_amountController.text),
                          createdAt: donation!.createdAt,
                          updatedAt: DateTime.now(),
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
