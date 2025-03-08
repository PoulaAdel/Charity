part of user;

class UserForm extends StatelessWidget {
  final User? user;
  final UserController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserForm({Key? key, required this.controller, this.user}) : super(key: key) {
    controller.setUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => TextFormField(
                      initialValue: controller.username.value,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onChanged: (value) => controller.username.value = value,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.role.value.toString(),
                      decoration: const InputDecoration(labelText: 'Role ID'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a role ID';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          controller.role.value = int.tryParse(value) ?? 0,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.phone.value,
                      decoration:
                          const InputDecoration(labelText: 'Contact Number'),
                      onChanged: (value) => controller.phone.value = value,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.email.value,
                      decoration: const InputDecoration(labelText: 'Email'),
                      onChanged: (value) => controller.email.value = value,
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.pickFaceImgFile,
                  child: const Text('Pick Face Image'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.submitForm(user);
                    }
                  },
                  child: Text(user == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
