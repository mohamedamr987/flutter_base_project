import 'package:flutter/material.dart';
import 'package:base_project/core/extensions/context_routing.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:base_project/core/theme/app_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  static bool _isVisible = false;
  static bool get isVisible => _isVisible;

  static Future<void> show() async {
    if (_isVisible) {
      navigatorKey.currentContext!.goBack();
    }
    _isVisible = true;
    await showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) {
        return const AppLoadingIndicator();
      },
    );
    _isVisible = false;
  }

  static Future<void> hide() async {
    if (!_isVisible) {
      return;
    }
    navigatorKey.currentContext!.goBack();
    _isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        child: const CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
