import 'package:flutter/material.dart';
import 'package:base_project/widgets/app_text.dart';

import '../core/helpers/app_colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  AppAppBar({
    Key? key,
    this.hMargin = 0,
    this.title,
    this.actions,
    this.leading,
    this.elevation,
    this.backgroundColor = AppColors.background,
    this.width,
  }) : super(key: key);
  final double hMargin;
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  double? elevation;
  final Color backgroundColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: backgroundColor,
      shadowColor: Colors.transparent,
      leadingWidth: width,
      leading: leading ??
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
      centerTitle: true,
      title: title != null
          ? AppText(
              title: title ?? '',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
