part of family;

class FamilyForm extends StatelessWidget {
  final Family? family;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final FamilyController controller = Get.find<FamilyController>();

  FamilyForm({Key? key, this.family}) : super(key: key) {
    if (family != null) {
      _nameController.text = family!.name;
      _countController.text = family!.count.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(family == null ? 'Add Family' : 'Edit Family'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                  controller: _countController,
                  decoration: const InputDecoration(labelText: 'Count'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a count';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (family == null) {
                        controller.addFamily(Family(
                          name: _nameController.text,
                          count: int.parse(_countController.text),
                          createdAt: DateTime.now(),
                        ));
                      } else {
                        controller.updateFamily(Family(
                          pk: family!.pk,
                          name: _nameController.text,
                          count: int.parse(_countController.text),
                          createdAt: family!.createdAt,
                          updatedAt: DateTime.now(),
                        ));
                      }
                      Get.back();
                    }
                  },
                  child: Text(family == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
