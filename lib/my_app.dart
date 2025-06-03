import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/theme/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: false,
        child: const SplashView(),
        builder: (_, child) => KeyboardPopScaffold(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: buildAppTheme(),
                  navigatorKey: navigatorKey,
                  home: child,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: const [Locale('ar'), Locale('en')],
                  locale: context.locale,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
