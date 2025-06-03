import 'package:base_project/core/assets/app_png_assets.dart';
import 'package:base_project/core/extensions/assets.dart';
import 'package:base_project/core/extensions/context_routing.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_project/views/noConnectionPage/no_connection_component.dart';
import 'package:base_project/views/noConnectionPage/no_connection_scaffold.dart';
import 'package:base_project/views/onboarding/view.dart';
import 'package:base_project/widgets/app_button.dart';

class SplashView extends StatefulWidget {
  static const String routeName = 'splash';
  static const String routePath = '/splash';
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
    super.initState();
  }

  void checkForStoreUpdate() async {
    navigatorKey.currentContext?.setLocale(Locale("ar"));
    await checkIfThereIsConnection();
    if (!isThereConnection) return;
    // await CachingUtils.clearCache();
    internetChecker();
    await Future.wait([]);
    context.navigateAndPopAll(OnboardingView.routeName);
    // if (CachingUtils.user != null) {
    //   await AuthDataSource.getMyProfile();
    //   print(
    //       "CachingUtils.user?.subscription ${CachingUtils.user.model?.subscription}, appFlavor: $appFlavor");
    //   if (CachingUtils.user == null) {
    //     RouteUtils.navigateAndPopAll(const HomeLayoutView());
    //     showSnackBar(LocalizationKeys.yourLoginCredentialsExpired.tr(),
    //         errorMessage: true);
    //   } else if (!CachingUtils.user.model!.active) {
    //     RouteUtils.navigateAndPopAll(const NotActiveView());
    //   } else {
    //     RouteUtils.navigateAndPopAll(const HomeLayoutView());
    //   }
    // } else
    //   RouteUtils.navigateAndPopAll(const HomeLayoutView());
    // final _appLinks = AppLinks();
    // _appLinks.uriLinkStream.listen((uri) {
    //   print("uriii" + uri.pathSegments.toString());
    //   if (uri.pathSegments.contains("product")) {}
    // });
  }

  Future<void> checkIfThereIsConnection() async {
    isThereConnection = await internet();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isThereConnection
          ? Stack(
              children: [
                AppPngAssets.splashBg.toFullScreenImage(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 42.w, vertical: 195.h),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          AppPngAssets.logo.toImage(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
