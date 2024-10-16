import 'package:flutter/material.dart';

import '../../../../shared/constants/app_constants.dart';
import '../../models/profile.dart';

class ProfilTile extends StatelessWidget {
  const ProfilTile(
      {required this.data, required this.onPressedLogOut, Key? key})
      : super(key: key);

  final Profile data;
  final Function() onPressedLogOut;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(backgroundImage: data.photo),
      title: Text(
        data.name,
        style: TextStyle(fontSize: 14, color: kFontColorPallets[0]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.email,
        style: TextStyle(fontSize: 12, color: kFontColorPallets[2]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: onPressedLogOut,
        icon: const Icon(Icons.logout),
        tooltip: "Logout",
      ),
    );
  }
}
