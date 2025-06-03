import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/helpers/dimensions.dart';

import 'package:base_project/widgets/app_text.dart';

import '../core/helpers/utils.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.child,
    required this.dismissible,
    required this.title,
    required this.headerColor,
  });

  final Widget child;
  final bool dismissible;
  final String title;
  final Color headerColor;

  static Future<dynamic> show(
      {required Widget child,
      String? title,
      bool dismissible = true,
      required Color headerColor}) {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      barrierColor: headerColor,
      builder: (context) {
        return AppDialog(
          child: child,
          dismissible: dismissible,
          headerColor: Colors.white,
          title: title ?? "",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      contentPadding: EdgeInsets.zero,
      content: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: keyboardHeight,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 54.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      title: title,
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                  if (dismissible)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: Utils.isAR ? null : 12,
                      right: Utils.isAR ? 12 : null,
                      child: UnconstrainedBox(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 32.height,
                            width: 32.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.white,
                            ),
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              child,
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
