import 'package:bematched/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  static String TABLE_NAME = "Comments";
  String? id;
  String? message;
  Timestamp? messageTime;
  String? senderId;

  CommentModel();

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    messageTime = json['messageTime'];
    senderId = json['sender_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['messageTime'] = messageTime;
    data['sender_id'] = senderId;
    return data;
  }

  Future addNewComment(String storyModelId) async {
    await FirebaseFirestore.instance
        .collection(StoryModel.TABLE_NAME)
        .doc(storyModelId)
        .collection(TABLE_NAME)
        .doc(id)
        .set(toJson(), SetOptions(merge: true));
  }
}
