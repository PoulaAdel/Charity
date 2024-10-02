import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class RecentMessages extends StatelessWidget {
  const RecentMessages({
    required this.onPressedMore,
    Key? key,
  }) : super(key: key);

  final Function() onPressedMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(EvaIcons.messageCircle),
        const SizedBox(width: 10),
        const Text(
          "Recent Messages",
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedMore,
          icon: const Icon(EvaIcons.moreVertical),
          tooltip: "more",
        )
      ],
    );
  }
}
