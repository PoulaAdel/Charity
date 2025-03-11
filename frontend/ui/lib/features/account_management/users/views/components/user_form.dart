part of user_management;

class UserForm extends StatelessWidget {
  final User? user;
  final UserManagementController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  UserForm({Key? key, required this.controller, this.user}) : super(key: key) {
    controller.setUser(user);
    usernameController.text = controller.username.value;
    roleController.text = controller.role.value.toString();
    phoneController.text = controller.phone.value;
    emailController.text = controller.email.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Add New User' : 'Edit User ${user!.pk}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Name can only contain letters';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.username.value = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: roleController,
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
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  decoration:
                      const InputDecoration(labelText: 'Contact Number'),
                  onChanged: (value) => controller.phone.value = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) => controller.email.value = value,
                ),
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
                      Get.back();
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
