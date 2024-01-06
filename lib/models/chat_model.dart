import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  static String TABLE_NAME = "chats";
  String? id;
  String? message;
  String? fileUrl;
  int? messageType;
  Timestamp? messageTime;
  String? senderId;
  bool? isRead;

  ChatModel();

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    fileUrl = json['fileUrl'];
    messageType = json['messageType'] ?? 0;
    messageTime = json['message_time'];
    senderId = json['sender_id'];

    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['fileUrl'] = fileUrl;
    data['messageType'] = messageType;
    data['message_time'] = messageTime;
    data['sender_id'] = senderId;

    data['isRead'] = isRead ?? false;
    return data;
  }
}

enum MessageType { text, image }
