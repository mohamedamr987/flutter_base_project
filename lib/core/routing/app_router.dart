import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:base_project/views/homeLayout/view.dart';
import 'package:base_project/views/noConnectionPage/no_connection_scaffold.dart';
import 'package:base_project/views/notActive/view.dart';
import 'package:base_project/views/onboarding/view.dart';
import 'package:base_project/views/splash/view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      name: SplashView.routeName,
      builder: (_, __) => const SplashView(),
    ),
    GoRoute(
      path: OnboardingView.routePath,
      name: OnboardingView.routeName,
      builder: (_, __) => const OnboardingView(),
    ),
    GoRoute(
      path: NoConnectionPage.routePath,
      name: NoConnectionPage.routeName,
      builder: (_, __) => const NoConnectionPage(),
    ),
    GoRoute(
      path: NotActiveView.routePath,
      name: NotActiveView.routeName,
      builder: (_, __) => const NotActiveView(),
    ),
    GoRoute(
      path: HomeLayoutView.routePath,
      name: HomeLayoutView.routeName,
      builder: (context, state) {
        final index = int.parse(state.pathParameters['index'] ?? '0');
        return HomeLayoutView(index: index);
      },
    ),
  ],
);
