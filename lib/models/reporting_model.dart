import 'dart:convert';

class ReportUser {
  String? reportingId;
  String? reportedId;
  String? messageId;
  String? groupId;
  ReportUser({
    this.reportingId,
    this.reportedId,
    this.messageId,
    this.groupId,
  });

  ReportUser copyWith({
    String? reportingId,
    String? reportedId,
    String? messageId,
    String? groupId,
  }) {
    return ReportUser(
      reportingId: reportingId ?? this.reportingId,
      reportedId: reportedId ?? this.reportedId,
      messageId: messageId ?? this.messageId,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (reportingId != null) {
      result.addAll({'reportingId': reportingId ?? ''});
    }
    if (reportedId != null) {
      result.addAll({'reportedId': reportedId ?? ''});
    }
    if (messageId != null) {
      result.addAll({'messageId': messageId ?? ''});
    }
    if (groupId != null) {
      result.addAll({'groupId': groupId ?? ''});
    }

    return result;
  }

  factory ReportUser.fromMap(Map<String, dynamic> map) {
    return ReportUser(
      reportingId: map['reportingId'],
      reportedId: map['reportedId'],
      messageId: map['messageId'],
      groupId: map['groupId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportUser.fromJson(String source) =>
      ReportUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportUser(reportingId: $reportingId, reportedId: $reportedId, messageId: $messageId, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportUser &&
        other.reportingId == reportingId &&
        other.reportedId == reportedId &&
        other.messageId == messageId &&
        other.groupId == groupId;
  }

  @override
  int get hashCode {
    return reportingId.hashCode ^
        reportedId.hashCode ^
        messageId.hashCode ^
        groupId.hashCode;
  }
}
