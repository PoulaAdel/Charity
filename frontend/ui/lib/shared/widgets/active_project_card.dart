import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import 'project_card.dart';

class ActiveProjectCard extends StatelessWidget {
  const ActiveProjectCard({
    required this.data,
    required this.onPressedSeeAll,
    Key? key,
  }) : super(key: key);

  final List<ProjectCardData> data;
  final Function() onPressedSeeAll;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title("My Active Project"),
                _seeAllButton(onPressed: onPressedSeeAll),
              ],
            ),
            const Divider(
              thickness: 1,
              height: kSpacing,
            ),
            const SizedBox(height: kSpacing),
            Row(
              children: data
                  .map((e) => Expanded(child: ProjectCard(data: e)))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _title(String value) {
    return Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _seeAllButton({required Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: kFontColorPallets[1]),
      child: const Text("See All"),
    );
  }
}
