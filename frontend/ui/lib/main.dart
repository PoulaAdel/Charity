import 'dart:ui';

import 'package:charity/utils/services/rest_api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/themes/app_theme.dart';

import 'config/routes/app_pages.dart';
import 'shared/constants/app_constants.dart';
import 'utils/localization/changelocal.dart';
import 'utils/localization/translation.dart';
import 'utils/services/app_prefrences_services.dart';
import 'utils/services/local_secure_storage_services.dart';
import 'utils/services/authetication_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for binding services must be called before
  // getting instances to be initialized
  await initialServices();

  // start UI
  runApp(const MyApp());
}

// Binding
Future<void> initialServices() async {
  // initial app prefrences
  await Get.putAsync(() => AppPrefrencesServices().init());
  // initial secure app prefrences (session)
  Get.put(LocalSecureStorage());
  // intial auhentication
  Get.put(AuthService(ApiPath.baseURL()));
  // initial RestAPI connection
  Get.put(RestApiServices(ApiPath.baseURL()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TrasnlationController trController = Get.put(TrasnlationController());
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      translations: EnArTranslation(),
      locale: trController.language,
      title: 'Charity',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.basic,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}
