// import 'package:dio/dio.dart';

import 'package:get/get.dart';

/// contains all service to get data from Server
class RestApiServices extends GetxService {
  static final RestApiServices _restApiServices = RestApiServices._internal();

  factory RestApiServices() {
    return _restApiServices;
  }
  RestApiServices._internal();

  // to get data from server, you can use Http for simple feature
  // or Dio for more complex feature

  // Example:
  // Future<ProductDetail?> getProductDetail(int id)async{
  //   var uri = Uri.parse(ApiPath.product + "/$id");
  //   try {
  //     return await Dio().getUri(uri);
  //   } on DioError catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }
}
