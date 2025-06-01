import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_dialog.dart';
import 'package:base_project/widgets/app_text.dart';

class AlertingDialog extends StatelessWidget {
  const AlertingDialog({
    Key? key,
    required this.alertTitle,
    required this.confirmTitle,
    this.cancelTitle,
  }) : super(key: key);

  final String alertTitle;
  final String confirmTitle;
  final String? cancelTitle;

  static Future<bool> show({
    required String alertTitle,
    required String confirmTitle,
    String? cancelTitle,
  }) async {
    final result = await AppDialog.show(
      title: 'warning'.tr(),
      headerColor: AppColors.black.withOpacity(0.8),
      child: AlertingDialog(
        alertTitle: alertTitle,
        confirmTitle: confirmTitle,
        cancelTitle: cancelTitle,
      ),
      dismissible: false,
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.triangleExclamation,
            color: AppColors.red,
            size: 120,
          ),
          SizedBox(height: 16),
          AppText(
            title: alertTitle,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          AppButton(
            title: confirmTitle,
            color: AppColors.red,
            onTap: () => Navigator.pop(context, true),
          ),
          SizedBox(height: 12),
          AppButton.outline(
            title: cancelTitle ?? 'cancel'.tr(),
            onTap: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
