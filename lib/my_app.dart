import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/helpers/app_colors.dart';
import 'core/route_utils/route_utils.dart';
import 'views/splash/view.dart';
import 'widgets/pop_scaffold.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      child: const SplashView(),
      builder: (_, child) => KeyboardPopScaffold(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              hoverColor: Colors.transparent,
              useMaterial3: false,
              textTheme: GoogleFonts.interTextTheme(),
              scaffoldBackgroundColor: AppColors.background,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              primaryColor: AppColors.primary,
            ),
            navigatorKey: navigatorKey,
            home: child,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: const [Locale('ar'), Locale('en')],
            locale: context.locale,
          ),
        ),
      ),
    );
  }
}
