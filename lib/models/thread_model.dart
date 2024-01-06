import 'package:cloud_firestore/cloud_firestore.dart';
import '../config.dart';
import '../screens/admin_base_controller.dart';
import '../utils/base_controller.dart';
import 'chat_model.dart';
import 'user_model.dart';

class ThreadModel {
  String? lastMessage;
  Timestamp? lastMessageTime;
  List<dynamic>? participantUserList;
  List<dynamic>? activeUserLIst;
  String? senderId;
  String? threadId;
  UserModel? userDetail;
  int? messageCount;
  String? fileUrl;
  bool? isPending;
  bool? isBlocked;


  static String TABLE_NAME = "threads";

  ThreadModel();

  ThreadModel.fromJson(Map<String, dynamic> json) {
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    participantUserList = json['participant_user_list'];
    activeUserLIst = json['active_user_list'];
    senderId = json['sender_id'];
    threadId = json['thread_id'];
    messageCount = json['message_count'];
    fileUrl = json['file_url'];
    isPending = json['is_pending'] ?? false;
    isBlocked = json['is_blocked'] ?? false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lastMessage != null) data['last_message'] = lastMessage;
    if (lastMessageTime != null) data['last_message_time'] = lastMessageTime;
    if (participantUserList != null) {
      data['participant_user_list'] = participantUserList;
    }
    if (activeUserLIst != null) data['active_user_list'] = activeUserLIst;
    if (senderId != null) data['sender_id'] = senderId;
    if (threadId != null) data['thread_id'] = threadId;
    if (messageCount != null) data['message_count'] = messageCount;
    if (fileUrl != null) data['file_url'] = fileUrl;
    data['is_pending'] = isPending ?? false;
    data['is_blocked'] = isBlocked ?? false;
    return data;
  }



  void readMessage() async {
    try {
      if (senderId != AdminBaseController.userData.value.uid) {
        await FirebaseFirestore.instance
            .collection(TABLE_NAME)
            .doc(threadId)
            .update({'message_count': 0});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static void deleteMessages(String threadId) async {
    final _baseController = BaseController(Get.context, (){});
    try {
      _baseController.showProgress();
      FirebaseFirestore.instance
          .collection(ThreadModel.TABLE_NAME)
          .doc(threadId)
          .update({
        'last_message': null,
        'last_message_time': null,
        'messageCount': 0,
        'sender_id': null
      });
      FirebaseFirestore.instance
          .collection(ThreadModel.TABLE_NAME)
          .doc(threadId)
          .collection(ChatModel.TABLE_NAME)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
      _baseController.hideProgress();
    } catch (e) {
      _baseController.hideProgress();
      print('Error: $e');
    }
  }


  @override
  String toString() {
    return threadId!;
  }
}
