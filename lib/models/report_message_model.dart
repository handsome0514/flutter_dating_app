import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

class ReportMessageModel {
  String? id;
  List<dynamic>? messages;
  int? type;
  Timestamp? report_time;
  List<dynamic>? sender_id;
  String? message_id;
  List<dynamic>? reported_userid;
  String? filePath;
  static String TABLE_NAME = "reported_users";
  static int MESSAGE_IMAGE = 0;
  static int MESSAGE_VOICE = MESSAGE_IMAGE + 1;
  static int MESSAGE_TEXT = MESSAGE_VOICE + 1;
  static int USER_REPORT = MESSAGE_TEXT + 1;
  static int GROUP_REPORT = USER_REPORT + 1;

  ReportMessageModel({
    this.id,
    this.messages,
    this.type,
    this.filePath,
    this.report_time,
    this.sender_id,
    this.message_id,
    this.reported_userid,
  });

  ReportMessageModel copyWith({
    String? id,
    List<dynamic>? message,
    int? type,
    Timestamp? report_time,
    List<dynamic>? sender_id,
    String? message_id,
    List<dynamic>? reported_userid,
  }) {
    return ReportMessageModel(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      type: type ?? this.type,
      report_time: report_time ?? this.report_time,
      sender_id: sender_id ?? [],
      message_id: message_id ?? this.message_id,
      reported_userid: reported_userid ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (messages != null) {
      result.addAll({'messages': messages});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (report_time != null) {
      result.addAll({'report_time': report_time!});
    }
    if (sender_id != null) {
      result.addAll({'sender_ids': sender_id});
    }
    if (message_id != null) {
      result.addAll({'message_id': message_id});
    }
    if (reported_userid != null) {
      result.addAll({'reported_userids': reported_userid});
    }

    if (filePath != null) {
      result.addAll({'file_path': filePath});
    }

    return result;
  }

  factory ReportMessageModel.fromMap(Map<String, dynamic> map) {
    return ReportMessageModel(
        id: map['id'],
        messages: map['messages'],
        type: map['type']?.toInt(),
        report_time: map['report_time'] != null ? map['report_time'] : null,
        sender_id: map['sender_ids'],
        message_id: map['message_id'],
        reported_userid: map['reported_userids'],
        filePath: map["file_path"]);
  }

  String toJson() => json.encode(toMap());

  factory ReportMessageModel.fromJson(String source) =>
      ReportMessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportMessageModel(id: $id, message: $messages, type: $type, report_time: $report_time, sender_id: $sender_id, message_id: $message_id, reported_userid: $reported_userid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportMessageModel &&
        other.id == id &&
        other.messages == messages &&
        other.type == type &&
        other.report_time == report_time &&
        other.sender_id == sender_id &&
        other.message_id == message_id &&
        other.reported_userid == reported_userid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        messages.hashCode ^
        type.hashCode ^
        report_time.hashCode ^
        sender_id.hashCode ^
        message_id.hashCode ^
        reported_userid.hashCode;
  }
}
