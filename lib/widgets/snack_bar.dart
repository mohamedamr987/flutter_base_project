import 'package:flutter/material.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:base_project/core/theme/app_colors.dart';

import 'app_text.dart';

void showSnackBar(
  String message, {
  bool errorMessage = false,
  duration = 5,
  Color color = AppColors.primary,
  SnackBarAction? action,
  BuildContext? context,
}) {
  if (message.trim().isEmpty) {
    return;
  }
  ScaffoldMessenger.of(context ?? navigatorKey.currentContext!)
      .hideCurrentSnackBar();
  ScaffoldMessenger.of(context ?? navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: errorMessage ? AppColors.red : color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.0,
      content: AppText(
        title: message,
        color: errorMessage ? AppColors.white : Colors.white,
        fontSize: 14,
      ),
      action: action ??
          SnackBarAction(
            label: '',
            onPressed: () {},
          ),
      duration: Duration(seconds: duration),
    ),
  );
}
