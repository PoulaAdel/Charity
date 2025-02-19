part of member;

class MemberForm extends StatelessWidget {
  final Member? member;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();
  final MemberController controller = Get.find<MemberController>();

  MemberForm({Key? key, this.member}) : super(key: key) {
    if (member != null) {
      _nameController.text = member!.name;
      _familyController.text = member!.family.toString();
      _relationController.text = member!.relation.toString();
      _contactController.text = member!.contact ?? '';
      _nidController.text = member!.nid.path;
      _imgController.text = member!.faceImg != null ? member!.faceImg!.url : '';
      _ageController.text = member!.age.toString();
      _educationController.text = member!.education ?? '';
      _incomeController.text = member!.income.toString();
      _healthController.text = member!.health ?? '';
    }
  }

  void dispose() {
    _nameController.dispose();
    _familyController.dispose();
    _relationController.dispose();
    _contactController.dispose();
    _nidController.dispose();
    _imgController.dispose();
    _ageController.dispose();
    _educationController.dispose();
    _incomeController.dispose();
    _healthController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member == null ? 'Add Member' : 'Edit Member'),
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
                  controller: _familyController,
                  decoration: const InputDecoration(labelText: 'Family'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a family ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _relationController,
                  decoration: const InputDecoration(labelText: 'Relation'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a relation ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: 'Contact'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nidController,
                  decoration: const InputDecoration(labelText: 'NID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a NID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _imgController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _educationController,
                  decoration: const InputDecoration(labelText: 'Education'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _incomeController,
                  decoration: const InputDecoration(labelText: 'Income'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _healthController,
                  decoration: const InputDecoration(labelText: 'Health'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (member == null) {
                        controller.addMember(Member(
                          name: _nameController.text,
                          family: int.parse(_familyController.text),
                          relation: int.parse(_relationController.text),
                          contact: _contactController.text,
                          nid: File(ImageRasterPath.avatar5),
                          faceImg: const NetworkImage(ImageRasterPath.avatar5),
                          age: int.parse(_ageController.text),
                          education: _educationController.text,
                          income: double.parse(_incomeController.text),
                          health: _healthController.text,
                          createdAt: DateTime.now(),
                        ));
                      } else {
                        controller.updateMember(Member(
                          pk: member!.pk,
                          name: _nameController.text,
                          family: int.parse(_familyController.text),
                          relation: int.parse(_relationController.text),
                          contact: _contactController.text,
                          nid: File(ImageRasterPath.avatar5),
                          faceImg: const NetworkImage(ImageRasterPath.avatar5),
                          age: int.parse(_ageController.text),
                          education: _educationController.text,
                          income: double.parse(_incomeController.text),
                          health: _healthController.text,
                          createdAt: member!.createdAt,
                          updatedAt: DateTime.now(),
                        ));
                      }
                      Get.back();
                    }
                  },
                  child: Text(member == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
