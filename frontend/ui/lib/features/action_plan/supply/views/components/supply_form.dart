part of supply;

class SupplyForm extends StatelessWidget {
  final Supply? supply;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController familyController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  SupplyForm({Key? key, this.supply}) : super(key: key) {
    if (supply != null) {
      familyController.text = supply!.family.toString();
      serviceController.text = supply!.service.toString();
      amountController.text = supply!.amount.toString();
      noteController.text = supply!.note ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final SupplyFormController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(supply == null ? 'Create Supply' : 'Edit Supply'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: familyController,
                decoration: const InputDecoration(labelText: 'Family ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a family ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: serviceController,
                decoration: const InputDecoration(labelText: 'Service ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(labelText: 'Note'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newSupply = Supply(
                      pk: supply?.pk,
                      family: int.parse(familyController.text),
                      service: int.parse(serviceController.text),
                      amount: double.parse(amountController.text),
                      note: noteController.text,
                    );
                    if (supply == null) {
                      controller.createSupply(newSupply);
                    } else {
                      controller.updateSupply(newSupply);
                    }
                    Get.back();
                  }
                },
                child: Text(supply == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
