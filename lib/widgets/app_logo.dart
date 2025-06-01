import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/dimensions.dart';

import '../core/helpers/utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width, this.height});

  final double? width;
  final double? height;

  factory AppLogo.white({
    double? width,
    double? height,
  }) {
    return _WhiteAppLogo(
      height: height,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Utils.getAssetPNGPath('logo'),
      width: width ?? 92.width,
      height: height ?? 92.height,
    );
  }
}

class _WhiteAppLogo extends AppLogo {
  const _WhiteAppLogo({
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Utils.getAssetPNGPath('white_logo'),
      width: width ?? 92.width,
      height: height ?? 92.height,
    );
  }
}
