import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/app_colors.dart';

class CacheImageWidget extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Color? color;
  const CacheImageWidget({
    super.key,
    required this.image,
    required this.fit,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: image,
      height: height,
      width: width,
      color: color,
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: AppColors.primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: AppColors.primary,
      ),
    );
  }
}
