import 'package:flutter/material.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/today_text.dart';
import '../../../shared/constants/app_constants.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TodayText(),
        const SizedBox(width: kSpacing),
        Expanded(child: SearchField()),
      ],
    );
  }
}
