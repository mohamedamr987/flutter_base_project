import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoDownloader {
  static Dio _dio = Dio();
  ValueNotifier<int> downloadProgress = ValueNotifier(0);
  ValueNotifier<File?> videoFile = ValueNotifier(null);

  Future<void> initVideo(String videoUrl) async {
    try {
      // Check if the file is already cached
      FileInfo? cachedFile =
          await DefaultCacheManager().getFileFromCache(videoUrl);
      if (cachedFile != null) {
        debugPrint("File already cached at ${cachedFile.file.path}");
        videoFile.value = cachedFile.file;
        return;
      }

      // If not cached, download with Dio
      final fileName = videoUrl.split('/').last;
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';

      await _dio.download(
        videoUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = ((received / total) * 100).toInt();
          }
        },
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Save the file to the cache
      final file = File(filePath);
      if (await file.exists()) {
        await DefaultCacheManager().putFile(
          videoUrl,
          file.readAsBytesSync(),
          fileExtension: fileName.split('.').last,
        );
        debugPrint("File downloaded and cached at $filePath");
      }

      videoFile.value = file;
    } catch (e) {
      debugPrint("Error downloading file: $e");
    }
  }
}
