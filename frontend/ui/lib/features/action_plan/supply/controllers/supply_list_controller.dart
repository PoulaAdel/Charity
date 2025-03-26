part of supply;

class SupplyListController extends GetxController {
  final RestApiServices _apiService = Get.find();
  final LocalSecureStorageServices _localSecureStorage = Get.find();
  final String _endPoint = 'supplies';

  var supplies = <Supply>[].obs;
  var filteredSupplies = <Supply>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Rx<Family?> selectedFamily = Rx<Family?>(null);
  Rx<Service?> selectedService = Rx<Service?>(null);

  var families = <Family>[].obs;
  var services = <Service>[].obs;

  @override
  void onInit() {
    super.onInit();
    assignFamilyAndService();
    fetchFamilies();
    fetchServices();
    fetchSupplies();
  }

  // Check and load family and Service from local storage
  void assignFamilyAndService() async {
    Family? storedFamily = await _localSecureStorage.getFamily();
    if (storedFamily != null) {
      selectedFamily.value = storedFamily;
    }

    Service? storedService = await _localSecureStorage.getService();
    if (storedService != null) {
      selectedService.value = storedService;
    }
  }

  // Fetch the list of families from the API
  Future<void> fetchFamilies() async {
    isLoading.value = true;
    try {
      var fetchedFamilies = await _apiService.get('families');
      families.value = (fetchedFamilies as List)
          .map((json) => Family.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch families: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch the list of services from the API
  Future<void> fetchServices() async {
    isLoading.value = true;
    try {
      var fetchedServices = await _apiService.get('services');
      services.value = (fetchedServices as List)
          .map((json) => Service.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch services: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSupplies() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final data = await _apiService.get(_endPoint);
      supplies.value = (data as List)
          .map((json) => Supply.fromJson(json as Map<String, dynamic>))
          .toList();
      filteredSupplies.value = supplies;
      print('Supplies fetched: ${supplies.length}');
    } catch (e) {
      errorMessage.value = 'Failed to fetch supplies: $e';
      Get.snackbar('Error', errorMessage.value); // Show snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSupply(Supply supply) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final newSupply = await _apiService.post(_endPoint, supply.toJson());
      supplies.add(Supply.fromJson(newSupply));
      filteredSupplies.add(Supply.fromJson(newSupply));
    } catch (e) {
      errorMessage.value = 'Failed to add supply: $e';
      Get.snackbar('Error', errorMessage.value); // Show snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSupply(Supply supply) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final updatedSupply =
          await _apiService.put('$_endPoint/${supply.pk}', supply.toJson());
      final index = supplies.indexWhere((s) => s.pk == supply.pk);
      if (index != -1) {
        supplies[index] = Supply.fromJson(updatedSupply);
        final filteredIndex =
            filteredSupplies.indexWhere((s) => s.pk == supply.pk);
        if (filteredIndex != -1) {
          filteredSupplies[filteredIndex] = Supply.fromJson(updatedSupply);
        }
      }
    } catch (e) {
      errorMessage.value = 'Failed to update supply: $e';
      Get.snackbar('Error', errorMessage.value); // Show snackbar
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSupply(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _apiService.delete('$_endPoint/$id');
      supplies.removeWhere((s) => s.pk == id);
      filteredSupplies.removeWhere((s) => s.pk == id);
    } catch (e) {
      errorMessage.value = 'Failed to delete supply: $e';
      Get.snackbar('Error', errorMessage.value); // Show snackbar
    } finally {
      isLoading.value = false;
    }
  }

  void filterSupplies(String query) {
    if (query.isEmpty) {
      filteredSupplies.value = supplies;
    } else {
      if ((selectedFamily.value != null)) {
        filteredSupplies.value = supplies
            .where((supply) =>
                supply
                    .toJson()
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                (supply.family == selectedFamily.value!.pk))
            .toList();
      } else {
        filteredSupplies.value = supplies
            .where((supply) => supply
                .toJson()
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    }
  }

  void clearFilter() {
    filteredSupplies.value = supplies;
  }

  Future<void> resetService() async {
    // Reset the selected Service
    selectedService.value = null;
    await _localSecureStorage.deleteService();
  }

  Future<void> resetFamily() async {
    // Reset the selected family
    selectedFamily.value = null;
    await _localSecureStorage.deleteFamily();
  }

  Future<void> clearData() async {
    await resetFamily();
    await resetService();
    update();
  }

  // Choose a family from the list
  Future<Family?> chooseFamily() async {
    RxList<Family> filteredFamilies = families;

    Family? selectedFamily = await Get.dialog<Family>(
      AlertDialog(
        title: Row(
          children: [
            const Text('Choose Family'),
            const SizedBox(width: 10),
            const Divider(),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Filter by name or ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) async {
                  isLoading.value = true;
                  if (value.isNotEmpty) {
                    filteredFamilies.value = families.where((family) {
                      return family.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          family.pk.toString().contains(value);
                    }).toList();
                  } else {
                    await fetchFamilies();
                  }
                  isLoading.value = false;
                },
              ),
            ),
          ],
        ),
        content: Obx(
          () {
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (filteredFamilies.isEmpty) {
              return const Center(
                child: Text('No families found'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredFamilies.map((family) {
                    return TextButton(
                      onPressed: () => Get.back(result: family),
                      child: Text(
                        '# ${family.pk} : ${family.name}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );

    if (selectedFamily != null) {
      return families.firstWhere((family) => family.pk == selectedFamily.pk);
    }
    return null;
  }

  // Choose a service from the list
  Future<Service?> chooseService() async {
    RxList<Service> filteredServices = services;

    Service? selectedService = await Get.dialog<Service>(
      AlertDialog(
        title: Row(
          children: [
            const Text('Choose Service'),
            const SizedBox(width: 10),
            const Divider(),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Filter by name or ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) async {
                  isLoading.value = true;
                  if (value.isNotEmpty) {
                    filteredServices.value = services.where((service) {
                      return service.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          service.pk.toString().contains(value);
                    }).toList();
                  } else {
                    await fetchServices();
                  }
                  isLoading.value = false;
                },
              ),
            ),
          ],
        ),
        content: Obx(
          () {
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (filteredServices.isEmpty) {
              return const Center(
                child: Text('No services found'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredServices.map((service) {
                    return TextButton(
                      onPressed: () => Get.back(result: service),
                      child: Text(
                        '# ${service.pk} : ${service.name}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );

    if (selectedService != null) {
      return services.firstWhere((service) => service.pk == selectedService.pk);
    }
    return null;
  }
}
