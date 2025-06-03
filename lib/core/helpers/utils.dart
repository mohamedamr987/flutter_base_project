import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:base_project/core/routing/app_router.dart';
import 'package:location/location.dart';
import 'package:base_project/core/caching_utils/caching_utils.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/helpers/dimensions.dart';
import 'package:base_project/core/models/user.dart' as user;
import 'package:geolocator/geolocator.dart';
import 'package:base_project/widgets/app_loading_indicator.dart';

import '../../widgets/snack_bar.dart';

class Utils {
  static const String dummyProductImage =
      "https://img.freepik.com/free-vector/realistic-vector-icon-plastic-bottle-water-isolated-white-background-beverage-drink-mockup_134830-1356.jpg?size=626&ext=jpg&ga=GA1.1.1412446893.1704758400&semt=ais";

  static const String mapAPIKey = 'AIzaSyDDE5HAogSmn1mfQfqrS2yr6czG5oQCAoE';

  static Color getColor(String color) {
    final myColor = "0xff${color.replaceFirst("#", "")}";
    return Color(int.parse(myColor));
  }

  static String getAssetPNGPath(String image) {
    return 'assets/images/png/$image.png';
  }

  static String getAssetSVGPath(String image) {
    return 'assets/images/svg/$image.svg';
  }

  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ["٠", "١", '٢', '٣', '٤', "٥", "٦", "٧", "٨", "٩"];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(
        arabic[i],
        english[i],
      );
    }
    print(input);
    return input;
  }

  static double get bottomDevicePadding {
    final bottom = MediaQuery.of(navigatorKey.currentContext!).padding.bottom;
    if (bottom < 34) {
      return 34.height;
    }
    return bottom;
  }

  static double get topDevicePadding {
    final top = MediaQuery.of(navigatorKey.currentContext!).padding.top;
    if (top < 44) {
      return 44.height;
    }
    return top;
  }

  static double get appBarHeight {
    return AppBar().preferredSize.height;
  }

  static double get keyboardHeight {
    final keyboardHeight =
        MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom;
    if (keyboardHeight == 0) {
      return keyboardHeight;
    }
    return keyboardHeight + 16.height;
  }

  static bool get isAR {
    return navigatorKey.currentContext!.locale.languageCode == 'ar';
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String getFileNameFromURL(String url, String symbol) =>
      url.substring(url.lastIndexOf(symbol) + 1);

  static String formatDate(DateTime? value) {
    if (value == null) {
      return "";
    }
    return "${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}";
  }

  static String formatTime(TimeOfDay? value) {
    if (value == null) {
      return "";
    }
    final hours = value.hour;
    return '${((hours > 12) ? hours - 12 : hours == 0 ? 12 : hours).toString().padLeft(2, '0')}:${(value.minute).toString().padLeft(2, '0')} ${value.period.name.toUpperCase()}';
  }

  static TimeOfDay convertToTimeOfDay(String value) {
    List<String> timeParts = value.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1].split(' ')[0]);
    String period = timeParts[1].split(' ')[1];
    if (period == 'PM' && hours != 12) {
      hours += 12;
    } else if (period == 'AM' && hours == 12) {
      hours = 0;
    }
    return TimeOfDay(hour: hours, minute: minutes);
  }

  static ThemeData get datePickerTheme {
    return Theme.of(navigatorKey.currentContext!).copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.secondary,
        onSurface: AppColors.secondary,
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 10,
          ),
          bodyLarge: TextStyle(
            color: AppColors.primary,
          ),
          labelSmall: TextStyle(
              color: AppColors.secondary,
              fontSize: 16,
              fontWeight: FontWeight.w700)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      ),
    );
  }

  static double getFileSizeInMB(File file) {
    int fileSizeInBytes = file.lengthSync();
    double fileSizeInKB = fileSizeInBytes / 1024;
    double fileSizeInMB = fileSizeInKB / 1024;
    return fileSizeInMB;
  }

  static String getChannelName(user.User user) {
    String storeName =
        user.role == "store" ? user.id : CachingUtils.user.model!.id;
    String customerName =
        user.role == "user" ? user.id : CachingUtils.user.model!.id;
    return storeName + customerName;
  }

  static Future<LatLng?> getCurrentLocation({
    bool showMessage = true,
    bool showLoading = false,
  }) async {
    if (showLoading) AppLoadingIndicator.show();

    if (!(await Location.instance.requestService())) {
      if (showLoading) AppLoadingIndicator.hide();
      return null;
    }
    final status = await Location.instance.requestPermission();

    print(status);

    if (status != PermissionStatus.granted) {
      if (showLoading) AppLoadingIndicator.hide();
      return null;
    }
    print("started getting location");
    final position = await Geolocator.getCurrentPosition();

    print("finished getting location");
    if (showLoading) AppLoadingIndicator.hide();
    final currentLocation = LatLng(position.latitude, position.longitude);

    return currentLocation;
  }

  static Future<num> calculateDistanceBetweenTwoLocationsInKm(
      LatLng location1, LatLng location2) async {
    final distance = await Geolocator.distanceBetween(
      location1.latitude,
      location1.longitude,
      location2.latitude,
      location2.longitude,
    );
    return distance / 1000;
  }

  static String calculateTravelTime(num distance) {
    // car speed is 60 km/h
    final time = distance / 60;
    // if less than 1 hour return minutes
    if (time < 1) {
      return "${(time * 60).toStringAsFixed(0)} min";
    }
    return "${time.toStringAsFixed(0)} h";
  }
}

void handleGenericException(dynamic e, StackTrace s) {
  const char = "-";
  final divider = char * 40;
  FirebaseCrashlytics.instance
      .recordError(e, s, fatal: true, printDetails: true);
  logError(e, s) {
    debugPrint('');
    debugPrint("$divider Unexpected Error $divider");
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
    debugPrint(divider + divider + "-" * 22);
    debugPrint('');
    log(e.toString());
    showSnackBar('Unexpected Error', errorMessage: true);
  }

  try {
    logError(e, e.stackTrace);
  } catch (_, s) {
    logError(e, s);
  }
}
