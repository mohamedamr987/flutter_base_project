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
          Image.asset(
            "assets/images/png/logo_without_background_${currentFlavor.name}${currentFlavor == Flavor.dates ? '_black' : ''}.png",
            width: 121,
            height: 121,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "you_are_not_signed_in".tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "do_you_want_to_sign_in".tr(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AppButton(
            title: "sign_in".tr(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
