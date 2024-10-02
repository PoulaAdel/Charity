import 'package:flutter/material.dart';
import '../../../shared/constants/app_constants.dart';

class SearchField extends StatelessWidget {
  SearchField({this.onSearch, this.hText, Key? key}) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;
  final String? hText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(EvaIcons.search),
        hintText: (hText == null) ? "Search ..." : hText,
        isDense: true,
        fillColor: Theme.of(context).cardColor,
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (onSearch != null) onSearch!(controller.text);
      },
      textInputAction: TextInputAction.search,
      style: TextStyle(color: kFontColorPallets[1]),
    );
  }
}
