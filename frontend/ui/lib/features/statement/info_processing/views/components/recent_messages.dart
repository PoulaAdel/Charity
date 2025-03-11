part of info_processing;

class _RecentMessages extends StatelessWidget {
  const _RecentMessages({
    required this.onPressedMore,
    Key? key,
  }) : super(key: key);

  final Function() onPressedMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.message_rounded),
        const SizedBox(width: 10),
        const Text(
          "Recent Messages",
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedMore,
          icon: const Icon(Icons.more),
          tooltip: "more",
        )
      ],
    );
  }
}
