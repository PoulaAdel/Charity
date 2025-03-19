import 'package:charity/config/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/app_constants.dart';

class SearchFieldController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var filteredOptions = <String>[].obs;
  final initialOptions = AppPages.routes.map((route) => route.name).toList();

  SearchFieldController();

  void filterOptions() {
    filteredOptions.value = initialOptions
        .where((option) =>
            option.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }
}

class SearchField extends StatelessWidget {
  const SearchField({this.onSearch, this.hText, Key? key}) : super(key: key);

  final Function(String value)? onSearch;
  final String? hText;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SearchFieldController());
    final controller = Get.find<SearchFieldController>();

    return Stack(
      children: [
        TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            hintText: (hText == null) ? "Go to..." : hText,
            isDense: true,
            fillColor: Theme.of(context).cardColor,
          ),
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
            if (onSearch != null) onSearch!(controller.searchController.text);
          },
          onChanged: (value) {
            controller.filterOptions();
          },
          textInputAction: TextInputAction.search,
          style: TextStyle(color: kFontColorPallets[1]),
        ),
        Obx(() {
          if (controller.filteredOptions.isNotEmpty) {
            return Positioned(
              left: 0,
              right: 0,
              top: 60, // Adjust this value based on your TextField height
              child: Material(
                elevation: 4.0,
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: controller.filteredOptions
                        .map((option) => ListTile(
                              title: Text(option),
                              onTap: () {
                                controller.searchController.text = '';
                                FocusScope.of(context).unfocus();
                                (onSearch != null)
                                    ? onSearch!(option)
                                    : Get.offAllNamed(option);
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
