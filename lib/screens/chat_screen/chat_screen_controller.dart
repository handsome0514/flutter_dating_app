import 'dart:async';
import 'dart:developer';
import 'package:bematched/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../config.dart';
import '../../models/chat_model.dart';
import '../../models/thread_model.dart';
import '../../network_service/network_services.dart';
import '../../utils/extension.dart';
import '../../widgets/custom_dailogs.dart';
import '../admin_base_controller.dart';

class ChatScreenController extends GetxController {
  ChatScreenController(this.threadModel);

  int lastCount = 20;
  Rx<bool> isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxList<ChatModel> messageList = RxList([]);
  QueryDocumentSnapshot<Map<String, dynamic>>? lastMessageDocument;
  ThreadModel? threadModel;
  TextEditingController chatController = TextEditingController();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? messageStream;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? threadStream;
  List<String> pathList = [];
  FocusNode focusNode = FocusNode();

  //***********************************************************************************

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      log('scroll listening');
      loadChat();
    }
  }

  void chatList() {
    CustomDailogs.chatDetailBox(
      Get.context!,
      threadModel: threadModel!,
    );
  }

//*************************************************************************************
  @override
  void onInit() async {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        NetWorkServices.setUserStatus(ChatStatus.typing.index);
        return;
      }
      NetWorkServices.setUserStatus(ChatStatus.online.index);
    });
    log('userModel: ${threadModel?.userDetail}');
    scrollController.addListener(onScroll);
    await loadChat();
    loadthreadModel();
    attachMessagesListener();
    update();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() async {
    await messageStream?.cancel();
    await threadStream?.cancel();
    // TODO: implement onClose
    super.onClose();
  }

  void filePick() async {
    var files = await CustomDailogs.photo_picker(Get.context!, maxPhoto: 1);
    if (files.isNotEmpty) {
      for (var e in files) {
        pathList.add(e.path);
      }
      update(['bottom']);
    }
  }

  //************************************************************************************

  void loadthreadModel() {
    threadStream = FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadModel?.threadId!)
        .snapshots()
        .listen((event) async {
      log('threadModel: ${event.data()}');
      if (event.exists) {
        threadModel = ThreadModel.fromJson(event.data() ?? {});
        var userModel = await NetWorkServices.getUserDetailById(
            threadModel?.participantUserList![0] ==
                    AdminBaseController.userData.value.uid
                ? threadModel?.participantUserList![1]
                : threadModel?.participantUserList![0]);
        if (userModel != null) {
          threadModel?.userDetail = userModel;
        }

        log('**********Read Message Function is******************');
        if (threadModel != null) threadModel?.readMessage();
        update(['header']);
        if (threadModel?.isBlocked ?? false) {
          update(['bottom']);
        }
      }
      log("thread: ${ThreadModel.fromJson(event.data()!)}");
      log('threadModel: $threadModel');
    });
  }

  //**********************************************************************************

  Future<void> loadChat() async {
    log("count$lastCount");
    if (lastCount < 20) {
      return;
    }
    isLoading.value = true;
    Query<Map<String, dynamic>> snapShotQuery;
    snapShotQuery = FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadModel?.threadId)
        .collection(ChatModel.TABLE_NAME)
        .orderBy("message_time", descending: true)
        .limit(20);
    if (lastMessageDocument != null) {
      snapShotQuery = snapShotQuery.startAfterDocument(lastMessageDocument!);
    }
    var snapShot = await snapShotQuery.get();
    var messagesLIst = snapShot.docs.map((e) {
      lastMessageDocument = e;
      return ChatModel.fromJson(e.data());
    }).toList();
    lastCount = messagesLIst.length;
    messageList.addAll(messagesLIst);
    isLoading.value = false;
    update(['chat']);
  }

  //***********************************************************************************

  void sendMessage() async {
    log('hit button');
    log(threadModel!.messageCount.toString());
    log(threadModel!.senderId.toString());
    if (chatController.text.trim().isEmpty && pathList.isEmpty) return;
    var id = generateRandomString(15);
    ChatModel chatModel = ChatModel()
      ..id = id
      ..message = chatController.text
      ..senderId = AdminBaseController.userData.value.uid
      ..messageTime = Timestamp.now();
    try {
      if (pathList.isNotEmpty) {
        var url = await NetWorkServices.uploadImage(
            generateRandomString(15), pathList.first);
        chatModel
          ..fileUrl = url
          ..messageType = MessageType.image.index;
      }

      FirebaseFirestore.instance
          .collection(ThreadModel.TABLE_NAME)
          .doc(threadModel?.threadId)
          .collection(ChatModel.TABLE_NAME)
          .doc(id)
          .set(chatModel.toJson(), SetOptions(merge: true));
      FirebaseFirestore.instance
          .collection(ThreadModel.TABLE_NAME)
          .doc(threadModel?.threadId)
          .update({
        'last_message': chatController.text,
        'last_message_time': Timestamp.now(),
        'message_count':
            threadModel?.senderId != AdminBaseController.userData.value.uid
                ? 1
                : (threadModel?.messageCount ?? 0) + 1,
        'sender_id': AdminBaseController.userData.value.uid,
      });
      chatController.clear();
      pathList.clear();
      update(['bottom']);
    } catch (e) {
      log('error: $e');
    }
  }

  //*********************************************************************************

  void attachMessagesListener() async {
    //*******************************************************************
    messageStream = FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadModel?.threadId)
        .collection(ChatModel.TABLE_NAME)
        .orderBy("message_time", descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty) return;
      if (kDebugMode) {
        log("new message received");
      }
      var chat = ChatModel.fromJson(event.docs[0].data());

      if (messageList.firstWhereOrNull((element) => element.id == chat.id) !=
          null) return;
      if (kDebugMode) {
        log('****************Message inserted******************');
      }
      if (messageList.isEmpty) {
        if (kDebugMode) {
          log('********Empty condition works**********');
        }
        messageList.insert(0, chat);
        update(['chat']);
        return;
      }
      messageList.insert(0, chat);
      update(['chat']);
    });
  }
}
