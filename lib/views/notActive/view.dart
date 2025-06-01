import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/caching_utils/caching_utils.dart';
import 'package:base_project/core/helpers/utils.dart';
import 'package:base_project/core/route_utils/route_utils.dart';
import 'package:base_project/main.dart';
import 'package:base_project/views/splash/view.dart';
import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_text.dart';

class NotActiveView extends StatelessWidget {
  const NotActiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              Utils.getAssetPNGPath(
                  'logo_without_background_${currentFlavor.name}${currentFlavor == Flavor.dates ? '_black' : ''}'),
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 50),
            AppText(
              title:
                  //  CachingUtils.user?.status == "pending"
                  //     ? "your_account_under_review".tr()
                  //     :
                  "user_not_active".tr(),
              fontSize: 20,
              textAlign: TextAlign.center,
              color: Colors.black,
            ),
            if (CachingUtils.user?.deactivateReason != null) ...[
              const SizedBox(height: 20),
              AppText(
                title: CachingUtils.user!.deactivateReason!,
                fontSize: 16,
                textAlign: TextAlign.center,
                color: Colors.black,
              ),
            ],
            const SizedBox(height: 20),
            AppButton(
              title: "refresh".tr(),
              onTap: () async {
                RouteUtils.navigateAndPopAll(const SplashView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
