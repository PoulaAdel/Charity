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
import 'utils/ui/ui_utils.dart';

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
  Get.put(LocalSecureStorageServices());
  // intial auhentication
  Get.put(AuthenticationServices(ApiPath.baseURL()));
  // initial RestAPI connection
  Get.put(RestApiServices(ApiPath.baseURL()));
  // initial AppThemeService
  Get.put(AppThemeService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TrasnlationController trController = Get.put(TrasnlationController());
    final AppThemeService themeService = Get.find<AppThemeService>();
    return Obx(() {
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
        darkTheme: AppTheme.dark,
        themeMode: themeService.themeMode,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        defaultTransition: Transition.fadeIn,
      );
    });
  }
}
