import 'dart:convert';
import 'dart:io';

import 'package:charity/utils/services/local_secure_storage_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class RestApiServices extends GetxService {
  final String baseUrl;

  RestApiServices(this.baseUrl);

  Future<Map<String, String>> _getHeaders(
      {Map<String, String>? headers}) async {
    final token = await LocalSecureStorageServices.getToken();
    final defaultHeaders = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token',
    };
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }
    return defaultHeaders;
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    final response =
        await http.get(url, headers: await _getHeaders(headers: headers));

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse is List) {
        return decodedResponse;
      } else if (decodedResponse is Map<String, dynamic>) {
        return [decodedResponse]; // Wrap the single object in a list
      } else {
        Get.snackbar('API Communication Error',
            'Failed to load data: Unexpected response format');
        throw Exception('Unexpected response format');
      }
    } else {
      Get.snackbar('API Communication Error',
          'Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<http.Response> postMultipart(String endpoint,
      {required Map<String, String> fields,
      required Map<String, File?> files}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(await _getHeaders());
    fields.forEach((key, value) {
      request.fields[key] = value;
    });
    files.forEach((key, file) {
      if (file != null) {
        request.files.add(http.MultipartFile(
          key,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    });
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    final response = await http.post(url,
        headers: await _getHeaders(headers: headers), body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Data saved successfully',
      );
      return jsonDecode(response.body);
    } else {
      Get.snackbar('API Communication Error',
          'Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<http.Response> putMultipart(String endpoint,
      {required Map<String, String> fields,
      required Map<String, File?> files}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    var request = http.MultipartRequest('PUT', url)
      ..headers.addAll(await _getHeaders());
    fields.forEach((key, value) {
      request.fields[key] = value;
    });
    files.forEach((key, file) {
      if (file != null) {
        request.files.add(http.MultipartFile(
          key,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    });
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    final response = await http.put(url,
        headers: await _getHeaders(headers: headers), body: jsonEncode(data));

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Data updated successfully',
      );
      return jsonDecode(response.body);
    } else {
      Get.snackbar('API Communication Error',
          'Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<http.Response> patchMultipart(String endpoint,
      {required Map<String, String> fields,
      required Map<String, File?> files}) async {
    var request =
        http.MultipartRequest('PATCH', Uri.parse('$baseUrl/$endpoint/'))
          ..headers.addAll(await _getHeaders());
    files.forEach((key, file) {
      if (file != null) {
        request.files.add(http.MultipartFile(
          key,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    });
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<Map<String, dynamic>> patch(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    final response = await http.patch(url,
        headers: await _getHeaders(headers: headers), body: jsonEncode(data));

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Data updated successfully',
      );
      return jsonDecode(response.body);
    } else {
      Get.snackbar('API Communication Error',
          'Failed to update data:  ${response.statusCode}');
      throw Exception('Failed to update data:  ${response.statusCode}');
    }
  }

  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint/');
    final response =
        await http.delete(url, headers: await _getHeaders(headers: headers));
    if (response.statusCode == 204) {
      Get.snackbar('Success', 'Data deleted successfully');
    } else {
      Get.snackbar('API Communication Error',
          'Failed to delete data: ${response.statusCode}');
      throw Exception('Failed to delete data: ${response.statusCode}');
    }
  }
}
