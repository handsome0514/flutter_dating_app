class VerificationModel {
  static String TABLE_NAME = "VerificationCollection";
  String? id;
  String? userUid;
  String? photoUrl;
  String? gesture;

  VerificationModel();

  VerificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userUid = json['userUid'];
    photoUrl = json['photoUrl'];
    gesture = json['gesture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userUid'] = userUid;
    data['photoUrl'] = photoUrl;
    data['gesture'] = gesture;
    return data;
  }
}
