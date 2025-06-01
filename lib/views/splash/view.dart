import 'package:app_links/app_links.dart';
import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_project/core/caching_utils/caching_utils.dart';
import 'package:base_project/core/datasources/auth.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/main.dart';
import 'package:base_project/views/homeLayout/view.dart';
import 'package:base_project/views/noConnectionPage/no_connection_component.dart';
import 'package:base_project/views/noConnectionPage/no_connection_scaffold.dart';
import 'package:base_project/views/notActive/view.dart';
import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_loading_indicator.dart';
import 'package:base_project/widgets/snack_bar.dart';

import '../../../core/helpers/utils.dart';
import '../../../core/route_utils/route_utils.dart';

class SplashView extends StatefulWidget {
  final String? storeId;
  const SplashView({super.key, this.storeId});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isThereConnection = true;

  @override
  void initState() {
    checkForStoreUpdate();
    // AppLinks is singleton
// Subscribe to all events (initial link and further)

    super.initState();
  }

  void checkForStoreUpdate() async {
    navigatorKey.currentContext?.setLocale(Locale("ar"));
    await checkIfThereIsConnection();
    if (!isThereConnection) return;
    // await CachingUtils.clearCache();
    internetChecker();
    await Future.wait([]);
    if (CachingUtils.user != null) {
      await AuthDataSource.getMyProfile();
      print(
          "CachingUtils.user?.subscription ${CachingUtils.user?.subscription}, appFlavor: $appFlavor");
      if (CachingUtils.user == null) {
        RouteUtils.navigateAndPopAll(const HomeLayoutView());
        showSnackBar(LocalizationKeys.yourLoginCredentialsExpired.tr(),
            errorMessage: true);
      } else if (!CachingUtils.user!.active) {
        RouteUtils.navigateAndPopAll(const NotActiveView());
      } else {
        RouteUtils.navigateAndPopAll(const HomeLayoutView());
      }
    } else
      RouteUtils.navigateAndPopAll(const HomeLayoutView());
    final _appLinks = AppLinks();
    _appLinks.uriLinkStream.listen((uri) {
      print("uriii" + uri.pathSegments.toString());
      if (uri.pathSegments.contains("product")) {}
    });
  }

  Future<void> checkIfThereIsConnection() async {
    isThereConnection = await internet();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: isThereConnection
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 195.h),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        Utils.getAssetPNGPath(
                            'logo_without_background_${currentFlavor.name}${currentFlavor == Flavor.dates ? '_black' : ''}'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NoConnectionComponent(),
                    AppButton(
                      title: LocalizationKeys.tryAgain.tr(),
                      onTap: () {
                        setState(() {
                          isThereConnection = true;
                          checkForStoreUpdate();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
