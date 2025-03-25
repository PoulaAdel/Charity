part of supply;

class SupplyList extends StatelessWidget {
  SupplyList({super.key});

  final SupplyListController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplies List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navigate to the supply form for adding a new supply
              await Get.toNamed('/supply_form');
              controller.fetchSupplies(); // Refresh the list after adding
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.filteredSupplies.isEmpty) {
          return const Center(child: Text('No supplies available.'));
        }
        return ListView.builder(
          itemCount: controller.filteredSupplies.length,
          itemBuilder: (context, index) {
            final supply = controller.filteredSupplies[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(supply.pk.toString()),
                subtitle: Text(
                  'Family: ${supply.family}, Service: ${supply.service}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        // Navigate to the supply form for editing
                        await Get.toNamed('/supply_form', arguments: supply);
                        controller
                            .fetchSupplies(); // Refresh the list after editing
                      },
                    ),
                    IconButton(
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
      }),
    );
  }
}
