import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/dimensions.dart';

import 'package:base_project/core/theme/app_colors.dart';
import 'app_text.dart';

class AppCheckBoxTile extends StatefulWidget {
  const AppCheckBoxTile({
    super.key,
    required this.title,
    this.initialValue = false,
    this.onChanged,
    this.fontWeight = FontWeight.w500,
  });

  final String title;
  final bool initialValue;
  final void Function(bool value)? onChanged;
  final FontWeight fontWeight;

  @override
  State<AppCheckBoxTile> createState() => _AppCheckBoxTileState();
}

class _AppCheckBoxTileState extends State<AppCheckBoxTile> {
  bool value = false;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void toggleValue() {
    value = !value;
    setState(() {});
    if (widget.onChanged != null) widget.onChanged!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          visualDensity: VisualDensity(vertical: -4, horizontal: -4),
          onChanged: (v) => toggleValue(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          checkColor: AppColors.white,
          activeColor: AppColors.primary,
        ),
        SizedBox(width: 6.width),
        AppText(
          title: widget.title,
          fontWeight: widget.fontWeight,
          color: AppColors.darkGray,
          fontSize: 14,
        ),
      ],
    );
  }
}
