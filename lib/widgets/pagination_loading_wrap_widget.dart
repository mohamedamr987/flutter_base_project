import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/pagination_handler.dart';

import '../core/helpers/app_colors.dart';

class PaginationLoadingWrapWidget extends StatelessWidget {
  final Widget child;
  final PaginationHandler paginationHandler;
  final Color? color;
  final bool isTop;
  final CrossAxisAlignment? crossAxisAlignment;
  const PaginationLoadingWrapWidget({
    super.key,
    required this.child,
    required this.paginationHandler,
    this.color,
    this.isTop = false,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        if (!isTop) child,
        if (paginationHandler.isLoading)
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: CircularProgressIndicator(
                color: color ?? AppColors.primary,
              ),
            ),
          ),
        if (isTop) child,
      ],
    );
  }
}
