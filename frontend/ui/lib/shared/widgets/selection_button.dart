import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectionButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withAlpha((0.5 * 255).toInt()),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Colors.white.withAlpha((0.7 * 255).toInt()),
        ),
      ),
    );
  }
}
