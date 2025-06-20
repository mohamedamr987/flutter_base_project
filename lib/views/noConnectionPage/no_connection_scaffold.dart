import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:base_project/core/extensions/context_routing.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:base_project/l10n/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/views/noConnectionPage/no_connection_component.dart';
import 'package:base_project/views/splash/view.dart';
import 'package:base_project/widgets/app_button.dart';

StreamSubscription<List<ConnectivityResult>>? connectivityStream;

class NoConnectionPage extends StatelessWidget {
  static const String routeName = 'noConnection';
  static const String routePath = '/no-connection';
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: AppColors.darkGray,
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NoConnectionComponent(),
                  AppButton(
                    title: LocalizationKeys.tryAgain.tr(),
                    onTap: () => context.pushPageNamed(SplashView.routeName),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

void internetChecker() {
  bool isDialogShown = false;
  connectivityStream = Connectivity()
      .onConnectivityChanged
      .listen((List<ConnectivityResult> result) async {
    if ((await internet()) && isDialogShown) {
      isDialogShown = false;
      navigatorKey.currentContext!.goBack();
    } else if ((!await internet() ||
            result.contains(ConnectivityResult.none)) &&
        !isDialogShown) {
      isDialogShown = true;
      showDialog<String>(
        barrierDismissible: false,
        barrierColor: Colors.white,
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => const NoConnectionPage(),
      );
    }
  });
}

Future<bool> internet() async {
  bool result = await InternetConnectionChecker.instance.hasConnection;
  return result;
}
