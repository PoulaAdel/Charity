part of supply;

class SupplyFormController extends GetxController {
  // Initialize needed services
  final RestApiServices _apiService = Get.find();

  // Define observable variables
  var isLoading = false.obs;

  // Generalized method for API calls
  Future<void> _handleApiCall(Future<void> Function() apiCall,
      String successMessage, String errorMessage) async {
    try {
      await apiCall();
      Get.snackbar('Success', successMessage);
    } catch (e) {
      Get.snackbar('Error', '$errorMessage: $e');
    }
  }

  // Create a new supply
  Future<void> createSupply(Supply supply) async {
    await _handleApiCall(
      () => _apiService.post('supplies', supply.toJson()),
      'Supply created successfully',
      'Failed to create supply',
    );
  }

  // Update an existing supply
  Future<void> updateSupply(Supply supply) async {
    await _handleApiCall(
      () => _apiService.put('supplies/${supply.pk}', supply.toJson()),
      'Supply updated successfully',
      'Failed to update supply',
    );
  }
}
