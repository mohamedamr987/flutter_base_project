import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:base_project/widgets/app_text.dart';

class NoConnectionComponent extends StatelessWidget {
  const NoConnectionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/json/no_network.json',
        ),
        AppText(
          title: "noInternetConnectionPleaseTryAgain".tr(),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
