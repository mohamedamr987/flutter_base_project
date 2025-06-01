import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_option.dart';

showCameraOptionsBottomSheet({
  required BuildContext context,
  bool isCameraEnabled = true,
  bool isFileEnabled = false,
  bool isVideoEnabled = false,
  int count = 1,
  Color color = AppColors.primary,
}) =>
    showModalBottomSheet(
      barrierColor: Colors.black26,
      context: context,
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
                  if (isCameraEnabled)
                    CameraOption(
                      color: color,
                      text: "camera".tr(),
                      icon: Icons.camera_alt,
                      imageSource: ImageSource.camera,
                      count: count,
                      isVideo: isVideoEnabled,
                    ),
                  CameraOption(
                    color: color,
                    text: "gallery".tr(),
                    imageSource: ImageSource.gallery,
                    icon: Icons.photo,
                    count: count,
                    isVideo: isVideoEnabled,
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
                  title: "cancel".tr(),
                  color: color,
                ),
              ),
            ],
          ),
        );
      },
    );
