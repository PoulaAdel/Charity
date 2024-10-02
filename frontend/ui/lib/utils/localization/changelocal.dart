import 'package:flutter/cupertino.dart';
import '../../utils/services/app_prefrences_services.dart';
import 'package:get/get.dart';

class TrasnlationController extends GetxController {
  Locale? language;

  AppPrefrencesServices appPrefs = Get.find();

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    appPrefs.prefs.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = appPrefs.prefs.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
