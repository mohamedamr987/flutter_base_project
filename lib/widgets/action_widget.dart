import 'package:flutter/material.dart';
import 'package:base_project/widgets/app_text.dart';

class ActionWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  const ActionWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Icon(
                icon,
                color: textColor,
                size: 18,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            AppText(
              title: text,
              color: textColor,
              fontSize: 8,
            ),
          ],
        ),
      ),
    );
  }
}
