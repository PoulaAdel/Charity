part of donation_management;

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        TodayText(),
        SizedBox(width: kSpacing),
        Expanded(child: SearchField()),
      ],
    );
  }
}
