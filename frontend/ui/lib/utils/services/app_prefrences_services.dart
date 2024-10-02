import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrencesServices extends GetxService {
  late SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  Future<AppPrefrencesServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }
}
