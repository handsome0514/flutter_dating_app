import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? title;
  String? body;
  List<String>? receiverIds;
  String? senderId;
  Timestamp? timestamp;
  static String TABLE_NAME = "notifications";
  int? type;
  static const int CHAT_MESSAGE = 0;
  static const int GROUP_CHAT_MESSAGE = CHAT_MESSAGE + 1;
  static const int INVITE_NOTIFICATION = GROUP_CHAT_MESSAGE + 1;
  static const int SUPER_LIKE = INVITE_NOTIFICATION + 1;
  static const int ACCOUNT_BLOCKED = SUPER_LIKE + 1;

  NotificationModel fromJson(Map<String, dynamic> json,
      {bool isFromList = false}) {
    id = json["id"];
    title = json["title"];
    timestamp = json["time_stamp"];
    body = json["body"];
    type = json["type"];
    List<dynamic> selectedUserMap = json["receiver_ids"];
    receiverIds = selectedUserMap.map((e) => e.toString()).toList();
    senderId = json["sender_id"];

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['time_stamp'] = timestamp;
    data['body'] = body;
    data["receiver_ids"] = receiverIds;
    data["sender_id"] = senderId;
    data["type"] = type;
    return data;
  }
}
