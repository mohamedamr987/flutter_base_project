import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/route_utils/route_utils.dart';
import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_text.dart';

class AppDialogWidget extends StatelessWidget {
  final String title;
  final String confirmTitle;
  final String subtile;
  final bool showCancel;

  static Future<bool> show({
    required String title,
    required String confirmTitle,
    required String subtile,
    bool showCancel = true,
  }) async {
    final result = await showDialog<bool>(
      context: navigatorKey.currentContext!,
      builder: (context) => AppDialogWidget(
        title: title,
        confirmTitle: confirmTitle,
        subtile: subtile,
        showCancel: showCancel,
      ),
    );
    return result ?? false;
  }

  const AppDialogWidget({
    super.key,
    required this.title,
    required this.confirmTitle,
    required this.subtile,
    required this.showCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: title.isEmpty
          ? null
          : Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: Color(0xFFCCCCCC),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: AppText(
                title: subtile,
                fontSize: 20,
                color: const Color(0xFF333333),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 16),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (showCancel) ...[
          AppButton.outline(
            height: 44,
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width * 0.25,
            title: LocalizationKeys.no.tr(),
            onTap: () => navigatorKey.currentState!.pop(false),
            borderColor: const Color(0xFFDA4963),
            titleColor: const Color(0xFFDA4963),
          ),
          const SizedBox(width: 16),
        ],
        AppButton(
          title: confirmTitle,
          height: 44,
          width: MediaQuery.of(context).size.width * 0.25,
          onTap: () => navigatorKey.currentState!.pop(true),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
