import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/core/helpers/dimensions.dart';
import 'package:base_project/core/helpers/utils.dart';
import 'package:base_project/widgets/app_text.dart';

import 'app_loading_indicator.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.color = AppColors.primary,
    this.titleColor = AppColors.white,
    this.fontWeight = FontWeight.w400,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.height,
    this.titleFontSize = 18,
    this.isLoading = false,
    this.linearColor = false,
    this.width,
    this.borderColor,
    this.icon,
  });

  final String title;
  final Color color;
  final Color titleColor;
  final VoidCallback? onTap;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final double? height;
  final double titleFontSize;
  final bool isLoading;
  final bool linearColor;
  final double? width;
  final Color? borderColor;
  final Icon? icon;
  final FontWeight fontWeight;

  double get _radius => 30;

  factory AppButton.outline({
    required String title,
    Color borderColor = AppColors.primary,
    Color titleColor = AppColors.primary,
    VoidCallback? onTap,
    bool isLoading = false,
    Axis constrainedAxis = Axis.vertical,
    double? width,
    EdgeInsets? padding,
    double? height,
  }) {
    return _OutlineAppButton(
      title: title,
      onTap: onTap,
      color: Colors.white,
      borderColor: borderColor,
      titleColor: titleColor,
      isLoading: isLoading,
      width: width,
      padding: padding,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: isLoading
          ? AppLoadingIndicator()
          : InkWell(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                  Utils.dismissKeyboard();
                }
              },
              radius: _radius,
              borderRadius: BorderRadius.circular(_radius),
              child: Container(
                width: width,
                height: height ?? 56.height,
                padding: padding ?? EdgeInsets.symmetric(horizontal: 48.width),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_radius),
                  color: onTap == null ? AppColors.lightGray : color,
                  gradient: linearColor
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.secondary,
                            AppColors.third,
                          ],
                        )
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 10),
                    ],
                    AppText(
                      title: title,
                      color: titleColor,
                      fontSize: titleFontSize,
                      fontWeight: fontWeight,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _OutlineAppButton extends AppButton {
  _OutlineAppButton({
    required super.title,
    super.onTap,
    super.color = AppColors.primary,
    super.titleColor = AppColors.secondary,
    required super.isLoading,
    super.width,
    super.borderColor,
    super.height,
    super.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: isLoading
          ? AppLoadingIndicator()
          : InkWell(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                  Utils.dismissKeyboard();
                }
              },
              radius: _radius,
              borderRadius: BorderRadius.circular(_radius),
              child: Container(
                width: width,
                height: height ?? 56.height,
                alignment: Alignment.center,
                padding: padding ?? EdgeInsets.symmetric(horizontal: 48.width),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_radius),
                    color: color,
                    border: Border.all(
                      color: onTap == null
                          ? AppColors.darkGray
                          : borderColor ?? color,
                      width: 1,
                    )),
                child: AppText(
                  title: title,
                  color: onTap == null ? AppColors.darkGray : titleColor,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }
}
