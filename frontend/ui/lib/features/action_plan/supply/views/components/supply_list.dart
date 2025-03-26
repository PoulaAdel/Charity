part of supply;

class SupplyList extends StatelessWidget {
  SupplyList({super.key});

  final SupplyListController controller = Get.find<SupplyListController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.filteredSupplies.isEmpty) {
        return const Center(child: Text('No supplies available.'));
      }
      return ListView.builder(
        shrinkWrap: true, // Allow embedding in other widgets
        physics:
            const NeverScrollableScrollPhysics(), // Disable internal scrolling
        itemCount: controller.filteredSupplies.length,
        itemBuilder: (context, index) {
          final supply = controller.filteredSupplies[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text('Supply ID: ${supply.pk}'),
              subtitle: Text(
                'Family: ${supply.family}, Service: ${supply.service}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: Colors.green,
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      // add logic to prompt the supply for received
                    },
                  ),
                  IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      // Navigate to the supply form for editing
                      await Get.dialog(SupplyForm(supply: supply));
                      controller
                          .fetchSupplies(); // Refresh the list after editing
                    },
                  ),
                  IconButton(
                    color: Colors.red,
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      // Delete the supply
                      await controller.deleteSupply(supply.pk!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
