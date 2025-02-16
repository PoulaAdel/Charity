import 'package:flutter/material.dart';

class TeamMember extends StatelessWidget {
  const TeamMember({
    required this.totalMember,
    required this.onPressedAdd,
    Key? key,
  }) : super(key: key);

  final int totalMember;
  final Function() onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(text: "Team Member "),
              TextSpan(
                text: "($totalMember)",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedAdd,
          icon: const Icon(Icons.plus_one),
          tooltip: "add member",
        )
      ],
    );
  }
}
