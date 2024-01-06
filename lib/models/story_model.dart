import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class StoryModel {
  static String TABLE_NAME = "Stories";
  String? id;
  String? fileUrl;
  Timestamp? storyTime;
  String? senderId;
  UserModel? userDetail;


  StoryModel();

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['fileUrl'];
    storyTime = json['storyTime'];
    senderId = json['sender_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fileUrl'] = fileUrl;
    data['storyTime'] = storyTime;
    data['sender_id'] = senderId;
    return data;
  }

  Future addNewUserOrUpdate() async {
    await FirebaseFirestore.instance
        .collection(TABLE_NAME)
        .doc(id!)
        .set(toJson(), SetOptions(merge: true));
  }
}

