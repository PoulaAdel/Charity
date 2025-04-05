part of supply;

class SupplyList extends StatelessWidget {
  SupplyList({super.key});

  final SupplyListController controller = Get.find<SupplyListController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.filteredSupplies.isEmpty) {
        return const Center(
          child: Text(
            'No supplies available.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true, // Allow embedding in other widgets
        physics:
            const NeverScrollableScrollPhysics(), // Disable internal scrolling
        itemCount: controller.filteredSupplies.length,
        itemBuilder: (context, index) {
          final supply = controller.filteredSupplies[index];
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supply #${supply.pk} Details',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Supply ID: ${supply.pk}'),
                          Text('Family: ${supply.family}'),
                          Text('Service: ${supply.service}'),
                          Text('Supply Explanation: ${supply.note}'),
                          Text('Amount: ${supply.amount}'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.cardColor, // Match the theme's card color
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withAlpha(100),
                      child: Icon(Icons.inventory,
                          color: theme.colorScheme.primary),
                    ),
                    title: Text(
                      'Supply ID: ${supply.pk}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Family: ${supply.family}, Service: ${supply.service}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withAlpha((0.7 * 255).toInt()),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.green,
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            // Add logic to prompt the supply for received
                          },
                        ),
                        IconButton(
                          color: theme.colorScheme.secondary,
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            // Navigate to the supply form for editing
                            await Get.dialog(SupplyForm(supply: supply));
                            controller
                                .fetchSupplies(); // Refresh the list after editing
                          },
                        ),
                        IconButton(
                          color: theme.colorScheme.error,
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            // Prompt the user to confirm deletion
                            final confirm = await Get.dialog<bool>(
                              AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this supply?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              // Delete the supply
                              await controller.deleteSupply(supply.pk!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
