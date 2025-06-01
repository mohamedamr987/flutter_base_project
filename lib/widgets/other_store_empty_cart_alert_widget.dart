import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/core/route_utils/route_utils.dart';
import 'package:base_project/widgets/app_text.dart';

import 'app_button.dart';

class OtherStoreEmptyCartAlertWidget extends StatelessWidget {
  const OtherStoreEmptyCartAlertWidget({super.key});

  static Future<bool?> show() async {
    return showDialog<bool>(
      context: navigatorKey.currentContext!,
      builder: (context) => const OtherStoreEmptyCartAlertWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      content: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title:
                  "you_are_about_to_add_items_from_another_store_to_your_cart"
                      .tr(),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            AppText(
              title:
                  "do_you_want_to_clear_your_cart_and_add_the_new_items".tr(),
              fontSize: 14,
              color: AppColors.black,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width * 0.3,
                  title: "ok".tr(),
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                ),
                const SizedBox(width: 10),
                AppButton.outline(
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width * 0.3,
                  title: "cancel".tr(),
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  titleColor: Colors.black,
                  borderColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
