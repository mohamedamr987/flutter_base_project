import 'package:flutter/material.dart';

import '../core/helpers/utils.dart';

class KeyboardPopScaffold extends StatelessWidget {
  const KeyboardPopScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.dismissKeyboard,
      child: child,
    );
  }
}
