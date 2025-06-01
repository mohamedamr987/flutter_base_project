class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String role;
  final bool active;
  final String? deactivateReason;
  final String? gender;
  final bool isAdmin;
  final DateTime createdAt;
  final Subscription? subscription;
  int? totalNumberOfCheckedOutCarts;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.active,
    required this.deactivateReason,
    required this.gender,
    required this.isAdmin,
    required this.subscription,
    required this.createdAt,
    this.totalNumberOfCheckedOutCarts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? json["_id"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      role: json["role"] ?? "user",
      active: json["active"],
      deactivateReason: json["deactivateReason"],
      gender: json["gender"],
      isAdmin: json["isAdmin"] ?? false,
      createdAt: DateTime.parse(json["createdAt"]),
      totalNumberOfCheckedOutCarts: json["isCheckedOut"],
      subscription: json["subscription"] != null
          ? Subscription.fromJson(json["subscription"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "role": role,
      "active": active,
      "deactivateReason": deactivateReason,
      "gender": gender,
    };
  }
}

class Location {
  final double lat;
  final double lng;
  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: num.parse(json["lat"].toString()).toDouble(),
      lng: num.parse(json["lng"].toString()).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}

class Subscription {
  final String id;
  final String user;
  final String subscriptionType;
  final DateTime subscriptionStartDate;
  final DateTime subscriptionEndDate;
  final double subscriptionPrice;
  final String subscriptionStatus;
  final String? tranRef;
  final String? token;
  final bool accessible;
  final DateTime createdAt;

  Subscription({
    required this.id,
    required this.user,
    required this.subscriptionType,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.subscriptionPrice,
    required this.subscriptionStatus,
    required this.tranRef,
    required this.token,
    required this.createdAt,
    required this.accessible,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"],
      user: json["user"],
      subscriptionType: json["subscriptionType"],
      subscriptionStartDate: DateTime.parse(json["subscriptionStartDate"]),
      subscriptionEndDate: DateTime.parse(json["subscriptionEndDate"]),
      subscriptionPrice: double.parse(json["subscriptionPrice"].toString()),
      subscriptionStatus: json["subscriptionStatus"],
      tranRef: json["tranRef"],
      token: json["token"],
      createdAt: DateTime.parse(json["createdAt"]),
      accessible: json["accessible"] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": user,
      "subscriptionType": subscriptionType,
      "subscriptionStartDate": subscriptionStartDate.toIso8601String(),
      "subscriptionEndDate": subscriptionEndDate.toIso8601String(),
      "subscriptionPrice": subscriptionPrice,
      "subscriptionStatus": subscriptionStatus,
      "tranRef": tranRef,
      "token": token,
      "createdAt": createdAt.toIso8601String(),
      "accessible": accessible,
    };
  }
}
