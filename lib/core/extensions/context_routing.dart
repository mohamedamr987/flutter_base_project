import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextRouting on BuildContext {
  /// Pops the current route if possible
  void goBack<T extends Object?>([T? result]) {
    if (canPop()) {
      pop<T>(result);
    }
  }

  /// Pushes a new page onto the stack
  void pushPageNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
    String? fragment,
  }) {
    GoRouter.of(this).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Replaces the current page with a new one
  void navigateAndReplace(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    GoRouter.of(this).replaceNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Clears all pages and pushes the new one as root
  void navigateAndPopAll(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
    String? fragment,
  }) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
      fragment: fragment,
    );
  }
}
