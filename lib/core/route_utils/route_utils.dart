import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => null;

class RouteUtils {
  static BuildContext context = navigatorKey.currentContext!;

  static Future<dynamic> navigateTo(Widget page) async =>
      await navigatorKey.currentState!.push(_materialPageRoute(page));

  static Future<dynamic> navigateAndReplace(Widget page) async =>
      await navigatorKey.currentState!
          .pushReplacement(_materialPageRoute(page));

  static Future<dynamic> slideToRightAndReplace(Widget page) async =>
      await navigatorKey.currentState!
          .pushReplacement(SlideRightRoute(page: page));

  static Future<dynamic> slideToLeftAndReplace(Widget page) async =>
      await navigatorKey.currentState!
          .pushReplacement(SlideLeftRoute(page: page));

  static Future<dynamic> navigateAndPopAll(Widget page) async =>
      await navigatorKey.currentState!.pushAndRemoveUntil(
        _materialPageRoute(page),
        (_) => false,
      );

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
          _materialPageRoute(page), (route) => route.isFirst);

  static void pop([Object? result]) => navigatorKey.currentState!.pop(result);

  static Route<dynamic> _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

// Slide transition from left to right
class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;

  SlideLeftRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
