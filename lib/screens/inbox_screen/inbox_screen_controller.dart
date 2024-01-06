import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config.dart';
import '../../models/thread_model.dart';
import '../../models/user_model.dart';
import '../../network_service/network_services.dart';
import '../admin_base_controller.dart';

//*******************************************************************

class InboxScreenController
    extends GetxController //*******************************************************************
{
  List<UserModel> matchList = [];
  List<ThreadModel> messagesList = [];

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? matchSnapShot;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? messagesSnapShot;
  var unreadCount = 0.obs;

  //*******************************************************************
  @override
  void onInit()
  //*******************************************************************
  {
    super.onInit();

    loadMatches();
    loadMessages();
  }

  //*******************************************************************
  void loadMessages() async {
    //*******************************************************************
    matchSnapShot = FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .where("participant_user_list",
            arrayContains: AdminBaseController.userData.value.uid)
        .snapshots()
        .listen((event) async {
      List<ThreadModel> threads = [];
      update();
      if (event.docs.isNotEmpty) {
        unreadCount.value = 0;

        for (var snapShot in event.docs) {
          var threadModel = ThreadModel.fromJson(snapShot.data());
          var uid = threadModel.participantUserList?.firstWhereOrNull(
              (element) => element != AdminBaseController.userData.value.uid);
          log('UID>>>>>>$uid');
          var userModel = await NetWorkServices.getUserDetailById(uid);
          if (userModel != null) {
            threadModel.userDetail = userModel;
            threads.add(threadModel);
          }
        }
      }
      messagesList = threads;
      log('ThreadLoaded');
      update();
    });
  }

  //*******************************************************************
  void loadMatches() async {
    //*******************************************************************

    matchSnapShot = FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .where("matches", arrayContains: AdminBaseController.userData.value.uid)
        .snapshots()
        .listen((event) {
      matchList = event.docs.map((e) => UserModel.fromJson(e.data())).toList();
      update();
    });

    log("match loaded");
  }

  //*******************************************************************
  @override
  void onClose()
  //*******************************************************************
  {
    super.onClose();
    matchSnapShot?.cancel();
  }
}
