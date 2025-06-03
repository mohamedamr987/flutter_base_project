import 'package:base_project/core/assets/app_png_assets.dart';
import 'package:base_project/core/extensions/assets.dart';
import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/main.dart';
import 'package:base_project/widgets/app_button.dart';

class NotSignedWidget extends StatelessWidget {
  const NotSignedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          AppPngAssets.logo.toImage(
            width: 121,
            height: 121,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            LocalizationKeys.yourNotSignedToAccount.tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            LocalizationKeys.signInToContinue.tr(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AppButton(
            title: LocalizationKeys.signIn.tr(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
