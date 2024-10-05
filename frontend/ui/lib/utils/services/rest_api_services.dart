import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DRFClient extends GetxService {
  final String baseUrl;

  DRFClient(this.baseUrl);

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response =
        await http.put(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update data: ${response.statusCode}');
    }
  }

  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Failed to delete data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> patch(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response =
        await http.patch(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update data:  ${response.statusCode}');
    }
  }
}
