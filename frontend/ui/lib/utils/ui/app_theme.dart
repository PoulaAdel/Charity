part of ui_utils;

class AppThemeService extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  void updateThemeMode(ThemeMode newThemeMode) {
    _themeMode.value = newThemeMode;
    // Notify listeners or update the app state as needed
    Get.changeThemeMode(newThemeMode);
    update();
  }
}
