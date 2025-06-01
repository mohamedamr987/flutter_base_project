import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/core/route_utils/route_utils.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  static bool _isVisible = false;
  static bool get isVisible => _isVisible;

  static Future<void> show() async {
    if (_isVisible) {
      RouteUtils.pop();
    }
    _isVisible = true;
    await showDialog(
      context: RouteUtils.context,
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
    RouteUtils.pop();
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
