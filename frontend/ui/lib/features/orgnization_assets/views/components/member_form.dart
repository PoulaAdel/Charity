part of member;

class MemberForm extends StatelessWidget {
  final Member? member;
  final MemberController controller = Get.put(MemberController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MemberForm({Key? key, this.member}) : super(key: key) {
    controller.setMember(member);
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
                Obx(() => TextFormField(
                      initialValue: controller.family.value == 0
                          ? ''
                          : controller.family.value.toString(),
                      decoration: const InputDecoration(labelText: 'Family'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a family ID';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          controller.family.value = int.tryParse(value) ?? 0,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.relation.value == 0
                          ? ''
                          : controller.relation.value.toString(),
                      decoration: const InputDecoration(labelText: 'Relation'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a relation ID';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          controller.relation.value = int.tryParse(value) ?? 0,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.contact.value,
                      decoration: const InputDecoration(labelText: 'Contact'),
                      onChanged: (value) => controller.contact.value = value,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.age.value == 0
                          ? ''
                          : controller.age.value.toString(),
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an age';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          controller.age.value = int.tryParse(value) ?? 0,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.education.value,
                      decoration: const InputDecoration(labelText: 'Education'),
                      onChanged: (value) => controller.education.value = value,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.income.value == 0.0
                          ? ''
                          : controller.income.value.toString(),
                      decoration: const InputDecoration(labelText: 'Income'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => controller.income.value =
                          double.tryParse(value) ?? 0.0,
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormField(
                      initialValue: controller.health.value,
                      decoration: const InputDecoration(labelText: 'Health'),
                      onChanged: (value) => controller.health.value = value,
                    )),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.pickNidFile,
                  child: const Text('Pick NID File'),
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
                      controller.submitForm(member);
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
