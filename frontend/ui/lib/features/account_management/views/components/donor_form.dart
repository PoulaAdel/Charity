part of donor;

class DonorForm extends StatelessWidget {
  final Donor? donor;
  final DonorController controller = Get.put(DonorController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DonorForm({Key? key, this.donor}) : super(key: key) {
    controller.setDonor(donor);
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => TextFormField(
                      initialValue: controller.name.value,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onChanged: (value) => controller.name.value = value,
                    )),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.submitForm(donor);
                    }
                  },
                  child: Text(donor == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
