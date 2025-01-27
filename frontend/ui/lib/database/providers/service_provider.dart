part of app_providers;

class ServiceProvider with ChangeNotifier {
  final List<Service> _services = [];
  final String _baseUrl = ApiPath.baseURL();

  List<Service> get services => _services;

  Future<void> fetchServices() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _services.clear();
      _services.addAll(data.map((json) => Service.fromJson(json)).toList());
      notifyListeners();
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<void> addService(Service service) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(service.toJson()),
    );
    if (response.statusCode == 201) {
      _services.add(Service.fromJson(json.decode(response.body)));
      notifyListeners();
    } else {
      throw Exception('Failed to add service');
    }
  }

  Future<void> updateService(Service service) async {
    final response = await http.put(
      Uri.parse('$_baseUrl${service.pk}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(service.toJson()),
    );
    if (response.statusCode == 200) {
      final index = _services.indexWhere((s) => s.pk == service.pk);
      if (index != -1) {
        _services[index] = Service.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } else {
      throw Exception('Failed to update service');
    }
  }

  Future<void> deleteService(int pk) async {
    final response = await http.delete(Uri.parse('$_baseUrl$pk/'));
    if (response.statusCode == 204) {
      _services.removeWhere((service) => service.pk == pk);
      notifyListeners();
    } else {
      throw Exception('Failed to delete service');
    }
  }
}
