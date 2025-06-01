import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/app_colors.dart';
import 'package:base_project/core/models/notification_model.dart';
import 'package:base_project/core/route_utils/route_utils.dart';

class FirebaseNotificationHelper {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> getPermissionsIos() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> getNotifications() async {
    getPermissionsIos();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage");
      handleComingNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp");
      NotificationModel notificationModel =
          NotificationModel.fromJson(message.data);
      if (notificationModel.isClickable) {
        notificationModel.onTap();
      }
    });
  }

  static void checkIfThereIsNotificationFromBooted() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      handleComingNotification(message);
    }
  }

  static void handleComingNotification(RemoteMessage message) {
    print("handleComingNotification");
    print(message.notification?.body?.toString());
    print(message.notification?.title?.toString());
    print(message.data.toString());
    showTopSnackBarNotification(
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      NotificationModel.fromJson(message.data),
    );
    try {} catch (e, trace) {
      print(e);
      print(trace);
    }
  }

  static void showTopSnackBarNotification(
      String title, String body, NotificationModel notificationModel) {
    // make the snackbar show on top of the screen
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            body,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(navigatorKey.currentContext!).size.height -
            220 -
            MediaQuery.of(navigatorKey.currentContext!).padding.top -
            MediaQuery.of(navigatorKey.currentContext!).viewPadding.top,
        right: 12,
        left: 12,
      ),
      action: notificationModel.isClickable
          ? SnackBarAction(
              label: 'view'.tr(),
              onPressed: () {
                notificationModel.onTap();
              },
              textColor: Colors.black,
            )
          : null,
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}
