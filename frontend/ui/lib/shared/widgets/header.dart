import 'package:flutter/material.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/today_text.dart';
import '../../../shared/constants/app_constants.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
