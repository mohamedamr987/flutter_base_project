import 'package:base_project/views/homeLayout/view.dart';

enum NotificationType {
  general,
  store,
  supportMessage,
  chatRequest,
  chat,
  sellerVideo
}

class NotificationModel {
  String title;
  String? body;
  NotificationType type;
  String? notificationObjectId;
  DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.notificationObjectId,
    required this.createdAt,
  });

  bool get isClickable {
    return type == NotificationType.chat ||
        type == NotificationType.chatRequest ||
        type == NotificationType.sellerVideo;
  }

  void onTap() async {
    if ((type == NotificationType.chat) && notificationObjectId != null) {
    } else if (type == NotificationType.sellerVideo) {
      HomeLayoutView.navigateAndPopAll(index: 1);
    } else {
      HomeLayoutView.navigateAndPopAll();
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      type: NotificationType.values.firstWhere(
        (element) => element.name == json['notificationType'],
        orElse: () => NotificationType.general,
      ),
      notificationObjectId: json['notificationObjectId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'notificationType': type.name,
      'notificationObjectId': notificationObjectId,
    };
  }
}
