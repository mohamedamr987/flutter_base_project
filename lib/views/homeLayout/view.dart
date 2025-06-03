import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:base_project/core/caching_utils/caching_utils.dart';
import 'package:base_project/core/extensions/context_routing.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/helpers/firebase_notification_helper.dart';
import 'package:base_project/core/helpers/utils.dart';
import 'package:base_project/core/models/notification_model.dart';
import 'package:base_project/main.dart';
import 'package:base_project/widgets/app_text.dart';

import 'cubit.dart';

part 'units/body.dart';
part 'units/nav_bar.dart';

class HomeLayoutView extends StatefulWidget {
  static const String routeName = 'homeLayout';
  static const String routePath = '/home-layout';
  static double get height =>
      MediaQuery.of(navigatorKey.currentContext!).size.height -
      (92 + MediaQuery.of(navigatorKey.currentContext!).padding.bottom) -
      AppBar().preferredSize.height -
      24;
  final int index;
  const HomeLayoutView({super.key, this.index = 0});

  static navigateAndPopAll({int index = 0}) =>
      navigatorKey.currentContext!.navigateAndPopAll(
        HomeLayoutView.routeName,
        pathParameters: {
          'index': index.toString(),
        },
      );

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
  @override
  void initState() {
    super.initState();

    FirebaseNotificationHelper.messaging.getInitialMessage().then((message) {
      if (message != null) {
        final data = message.data;
        NotificationModel notificationModel = NotificationModel.fromJson(data);
        if (notificationModel.isClickable) {
          notificationModel.onTap();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<NavBarCubit>()),
      ],
      child: BlocBuilder<NavBarCubit, NavBarStates>(
        builder: (context, state) {
          return Scaffold(
            body: _Body(),
            bottomNavigationBar: _NavBar(),
          );
        },
      ),
    );
  }
}
