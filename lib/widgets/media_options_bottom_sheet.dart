import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/route_utils/route_utils.dart';
import 'package:base_project/widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_option.dart';

showMediaOptionsBottomSheet({
  required ImageSource imageSource,
  int count = 1,
  Color color = AppColors.primary,
}) =>
    showModalBottomSheet(
      barrierColor: Colors.black26,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 8,
          ),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // if(isFileEnabled)
                  //   CameraOption(
                  //     color: color,
                  //     text: LocaleKeys.file.tr(),
                  //     icon: Icons.attach_file,
                  //     pickService: PickFileService(),
                  //   ),

                  CameraOption(
                    color: color,
                    text: LocalizationKeys.photo.tr(),
                    icon: Icons.photo,
                    imageSource: imageSource,
                    count: count,
                    isVideo: false,
                  ),
                  CameraOption(
                    color: color,
                    text: LocalizationKeys.video.tr(),
                    imageSource: imageSource,
                    icon: Icons.videocam,
                    count: count,
                    isVideo: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppText(
                  title: LocalizationKeys.cancel.tr(),
                  color: color,
                ),
              ),
            ],
          ),
        );
      },
    );
