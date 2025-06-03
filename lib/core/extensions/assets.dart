import 'package:flutter/material.dart';

extension AssetsExtension on String {
  Image toImage({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) =>
      Image.asset(
        this,
        width: width,
        height: height,
        color: color,
        fit: fit,
      );
}
