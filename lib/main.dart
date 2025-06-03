import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base_project/core/helpers/firebase_notification_helper.dart';
import 'package:base_project/firebase_options_dev.dart' as firebase_options_dev;
import 'package:base_project/firebase_options_staging.dart'
    as firebase_options_staging;
import 'package:base_project/firebase_options_prod.dart'
    as firebase_options_prod;
import 'package:base_project/views/homeLayout/cubit.dart';
import 'core/caching_utils/caching_utils.dart';
import 'core/network_utils/network_utils.dart';
import 'my_app.dart';
import 'package:get_it/get_it.dart';

enum Flavor { dev, staging, prod }

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

final getIt = GetIt.instance;

void main() async {
  print("main start");
  Flavor currentFlavor = Flavor.values.firstWhere(
    (flavor) => appFlavor == flavor.name,
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }
  await Firebase.initializeApp(
    name: "base_project-9ad37",
    options: currentFlavor == Flavor.dev
        ? firebase_options_dev.DefaultFirebaseOptions.currentPlatform
        : currentFlavor == Flavor.staging
            ? firebase_options_staging.DefaultFirebaseOptions.currentPlatform
            : firebase_options_prod.DefaultFirebaseOptions.currentPlatform,
  );
  await Future.value([
    await NetworkUtils.init(),
    await EasyLocalization.ensureInitialized(),
    await CachingUtils.init(),
    // await FirebaseNotificationHelper.getNotifications(),
  ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  getIt.registerLazySingleton(() => NavBarCubit());
  print("appFlavor: $appFlavor");
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/lang',
      saveLocale: true,
      child: const MyApp(),
      assetLoader: RootBundleAssetLoader(),
    ),
  );
}

// TODO: Remove this code at production
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
