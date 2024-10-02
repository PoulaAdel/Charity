import 'package:flutter/material.dart';

import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/ui/search_field.dart';
import '../../../../shared/widgets/ui/today_text.dart';

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
