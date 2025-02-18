import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/ui/ui_utils.dart';
import 'profile.dart';

class ProfilTile extends StatelessWidget {
  ProfilTile({required this.data, required this.onPressedLogOut, Key? key})
      : super(key: key);

  final Profile data;
  final Function() onPressedLogOut;
  final _themeService = Get.find<AppThemeService>();

  void _toggleTheme(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final newThemeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    // Assuming you have a method to update the theme mode in your app
    // For example, using a provider or any state management solution
    _themeService.updateThemeMode(newThemeMode);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(backgroundImage: data.photo),
      title: Text(
        data.username,
        style: const TextStyle(fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.email,
        style: const TextStyle(fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (String result) {
          if (result == 'logout') {
            onPressedLogOut();
          } else if (result == 'toggle_theme') {
            _toggleTheme(context);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'toggle_theme',
            child: Obx(() {
              final isDarkMode = _themeService.themeMode == ThemeMode.dark;
              return Row(
                children: [
                  Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  const SizedBox(width: 8),
                  Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
                ],
              );
            }),
          ),
          const PopupMenuItem<String>(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 8),
                Text('Logout'),
              ],
            ),
          ),
        ],
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
