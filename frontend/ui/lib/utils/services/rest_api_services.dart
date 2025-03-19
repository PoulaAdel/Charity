import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'local_secure_storage_services.dart';

class RestApiServices extends GetxService {
  final String baseUrl;
  final Dio dio;

  RestApiServices(this.baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl));

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

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final url = '$baseUrl/$endpoint/';
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders(headers: headers)),
      );
      final decodedResponse = response.data;
      if (decodedResponse is List) {
        return decodedResponse;
      } else if (decodedResponse is Map<String, dynamic>) {
        return [decodedResponse];
      } else {
        Get.snackbar('API Communication Error',
            'Failed to load data: Unexpected response format');
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      Get.snackbar('API Communication Error',
          '${e is DioException ? e.response?.statusCode : 'Server Error'}');
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint/';
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: await _getHeaders(headers: headers)),
      );
      Get.snackbar('Success', 'Data saved successfully');
      return response.data;
    } catch (e) {
      Get.snackbar('API Communication Error',
          'Failed to load data: ${e is DioException ? e.response?.statusCode : 'Error'}');
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint/';
    try {
      final response = await dio.put(
        url,
        data: data,
        options: Options(headers: await _getHeaders(headers: headers)),
      );
      Get.snackbar('Success', 'Data updated successfully');
      return response.data;
    } catch (e) {
      Get.snackbar('API Communication Error',
          'Failed to load data: ${e is DioException ? e.response?.statusCode : 'Error'}');
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> patch(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint/';
    try {
      final response = await dio.patch(
        url,
        data: data,
        options: Options(headers: await _getHeaders(headers: headers)),
      );
      Get.snackbar('Success', 'Data updated successfully');
      return response.data;
    } catch (e) {
      Get.snackbar('API Communication Error',
          'Failed to update data: ${e is DioException ? e.response?.statusCode : 'Error'}');
      throw Exception('Failed to update data: ${e.toString()}');
    }
  }

  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    final url = '$baseUrl/$endpoint/';
    try {
      await dio.delete(url,
          options: Options(headers: await _getHeaders(headers: headers)));
      Get.snackbar('Success', 'Data deleted successfully');
    } catch (e) {
      Get.snackbar('API Communication Error',
          'Failed to delete data: ${e is DioException ? e.response?.statusCode : 'Error'}');
      throw Exception('Failed to delete data: ${e.toString()}');
    }
  }
}
