part of supply;

Widget _buildStickySection() {
  final SupplyListController controller = Get.find();
  return Card(
    elevation: 6,
    margin: const EdgeInsets.all(16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(
                  title: 'Family ID',
                  value:
                      controller.selectedFamily.value?.pk.toString() ?? 'N/A',
                  onChange: () async {
                    final family = await controller.chooseFamily();
                    if (family != null) {
                      controller._localSecureStorage.saveFamily(family);
                      controller.selectedFamily.value = family;
                    }
                  },
                  onCopy: () {
                    final familyId =
                        controller.selectedFamily.value?.pk.toString() ?? '';
                    Clipboard.setData(ClipboardData(text: familyId));
                    Get.snackbar('Copied', 'Family ID copied to clipboard');
                  },
                ),
                const SizedBox(width: 16),
                _buildInfoCard(
                  title: 'Service ID',
                  value:
                      controller.selectedService.value?.pk.toString() ?? 'N/A',
                  onChange: () async {
                    final service = await controller.chooseService();
                    if (service != null) {
                      controller._localSecureStorage.saveService(service);
                      controller.selectedService.value = service;
                    }
                  },
                  onCopy: () {
                    final serviceId =
                        controller.selectedService.value?.pk.toString() ?? '';
                    Clipboard.setData(ClipboardData(text: serviceId));
                    Get.snackbar('Copied', 'Service ID copied to clipboard');
                  },
                ),
              ],
            );
          }),
          const SizedBox(height: 20),
          _buildFullWidthActionButton(
            label: 'Clear Data',
            icon: Icons.delete,
            color: Colors.red,
            onPressed: controller.clearData,
          ),
          const SizedBox(height: 20),
          _buildFullWidthActionButton(
            label: 'Add new Supply',
            icon: Icons.plus_one,
            color: Colors.green,
            onPressed: () {}, //open dialog form to add new,
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoCard({
  required String title,
  required String value,
  required VoidCallback onChange,
  required VoidCallback onCopy,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onChange,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Change'),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onCopy,
                icon: const Icon(Icons.copy, color: Colors.blue),
                tooltip: 'Copy',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildFullWidthActionButton({
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}
