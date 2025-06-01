import 'package:flutter/material.dart';
import 'package:base_project/widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';

class CameraOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final ImageSource imageSource;
  final Color color;
  final int count;
  final bool isVideo;
  const CameraOption({
    Key? key,
    required this.text,
    required this.icon,
    required this.imageSource,
    required this.color,
    required this.count,
    this.isVideo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (imageSource == ImageSource.camera) {
          XFile? result = isVideo
              ? await ImagePicker().pickVideo(
                  source: imageSource,
                )
              : await ImagePicker().pickImage(
                  source: imageSource,
                  imageQuality: 50,
                );
          Navigator.pop(context, result);
          return;
        }
        if (count > 1 && !isVideo) {
          List<XFile> result = await ImagePicker().pickMultiImage(
            imageQuality: 50,
          );
          if (result.length > count) {
            result = result.sublist(0, count);
          }
          Navigator.pop(context, result);
          return;
        }
        XFile? result = isVideo
            ? await ImagePicker().pickVideo(
                source: imageSource,
              )
            : await ImagePicker().pickImage(
                source: imageSource,
                imageQuality: 50,
              );
        Navigator.pop(context, result);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            padding: const EdgeInsets.all(
              4,
            ),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          AppText(
            title: text,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
