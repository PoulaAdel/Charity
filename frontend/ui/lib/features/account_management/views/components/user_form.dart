part of user;

class UserForm extends StatelessWidget {
  final User? user;
  final _formKey = GlobalKey<FormState>();
  // final _userController = TextEditingController();
  // final _typeController = TextEditingController();
  // final _notesController = TextEditingController();
  // final _amountController = TextEditingController();
  final UserController controller = Get.find<UserController>();

  UserForm({Key? key, this.user}) : super(key: key) {
    if (user != null) {
      // _userController.text = user!.user.toString();
      // _typeController.text = user!.type.toString();
      // _notesController.text = user!.notes ?? '';
      // _amountController.text = user!.amount.toString();
    }
  }

  void dispose() {
    // _userController.dispose();
    // _typeController.dispose();
    // _notesController.dispose();
    // _amountController.dispose();
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
          child: const SingleChildScrollView(
            child: Column(
              children: [
                // TextFormField(
                //   controller: _userController,
                //   decoration: const InputDecoration(labelText: 'User'),
                //   keyboardType: TextInputType.number,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a user ID';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   controller: _typeController,
                //   decoration: const InputDecoration(labelText: 'Type'),
                //   keyboardType: TextInputType.number,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a type';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   controller: _notesController,
                //   decoration: const InputDecoration(labelText: 'Notes'),
                // ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   controller: _amountController,
                //   decoration: const InputDecoration(labelText: 'Amount'),
                //   keyboardType: TextInputType.number,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter an amount';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     if (_formKey.currentState!.validate()) {
                //       if (user == null) {
                //         controller.addUser(User(
                //           user: int.parse(_userController.text),
                //           type: int.parse(_typeController.text),
                //           notes: _notesController.text,
                //           amount: double.parse(_amountController.text),
                //           createdAt: DateTime.now(),
                //         ));
                //       } else {
                //         controller.updateUser(User(
                //           pk: user!.pk,
                //           user: int.parse(_userController.text),
                //           type: int.parse(_typeController.text),
                //           notes: _notesController.text,
                //           amount: double.parse(_amountController.text),
                //           createdAt: user!.createdAt,
                //           updatedAt: DateTime.now(),
                //         ));
                //       }
                //       Get.back();
                //     }
                //   },
                //   child: Text(user == null ? 'Add' : 'Update'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
