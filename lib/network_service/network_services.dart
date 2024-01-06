import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/models/story_model.dart';
import 'package:bematched/screens/auth/flow4_mode_screen/mode_screen.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/chat_model.dart';
import '../models/home_user_filter_model.dart';
import '../models/notification_model.dart';
import '../models/option_model.dart';
import '../models/report_message_model.dart';
import '../models/thread_model.dart';
import '../models/user_model.dart';
import '../screens/admin_base_controller.dart';
import '../screens/auth/flow1_name_screen/name_screen.dart';
import '../screens/auth/flow2_gender_screen/gender_screen.dart';
import '../screens/auth/flow3_birth_screen/birth_screen.dart';
import '../screens/auth/flow5_picture_screen/picture_screen.dart';
import '../screens/auth/flow6_interest_screen/interest_screen.dart';
import '../screens/auth/flow7_describe_screen/describe_screen.dart';
import '../screens/auth/flow8_lcoation_screen/location_screen.dart';
import '../screens/navbar_screen/navbar_screen.dart';
import '../utils/extension.dart';

//******************************************************************************
class NetWorkServices {
  //******************************************************************************

  //******************************************************************************
  static Future<UserModel?> signupUser(UserModel userModel) async {
    //******************************************************************************

    try {
      var authUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userModel.email!, password: userModel.password!);
      userModel.uid = authUser.user?.uid ?? "";
      AdminBaseController.updateUser(userModel);
      await userModel.addNewUserOrUpdate();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw AppException(e.message);
      return null;
    }
    return null;
  }

  //******************************************************************************
  static Future<UserModel?> loginUser(UserModel userModel) async {
    //******************************************************************************

    try {
      var authUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userModel.email!, password: userModel.password!);
      userModel.uid = authUser.user?.uid ?? "";
      return await UserModel.getUserDetail(userModel.uid ?? '');
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw AppException(e.message);
      return null;
    }
    return null;
  }

  //******************************************************************************
  static Future<UserModel?> getUserDetail() async {
    //******************************************************************************

    try {
      if (FirebaseAuth.instance.currentUser == null) return null;
      return await UserModel.getUserDetail(
          FirebaseAuth.instance.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw AppException(e.message);
      return null;
    }
    return null;
  }

  //******************************************************************************
  static Future<UserModel?> getUserDetailById(String uid) async {
    //******************************************************************************

    try {
      if (FirebaseAuth.instance.currentUser == null) return null;
      return await UserModel.getUserDetail(uid);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw AppException(e.message);
      return null;
    }
    return null;
  }

  //******************************************************************************
  static Future<String> uploadUserImage(String uid, String path) async {
    //******************************************************************************

    try {
      return await uploadImage("users/$uid/profile", path);
    } on Exception catch (e) {
      throw AppException(e.toString());
    }
  }

  static Future deleteFile(String url) async {
    if ((url.isEmpty) || !url.contains("firebasestorage")) {
      return;
    }

    try {
      Reference photoRef = FirebaseStorage.instance.refFromURL(url);
      print(photoRef.fullPath);
      if (photoRef.isBlank == false) await photoRef.delete();
    } on Exception catch (e) {
      // TODO
    }
  }

  //******************************************************************************
  static Future<String> uploadImage(String uid, String path) async {
    //*****************************************************************************
    Reference reference = FirebaseStorage.instance.ref().child(uid);
    UploadTask uploadTask = reference.putFile(File(path));
    TaskSnapshot snapshot = await uploadTask;
    var url = await snapshot.ref.getDownloadURL();
    print(url);
    return url;
  }

  static Future<List<UserModel>> getHomeUsers(
      HomeFilterModel userFilter) async {
    int pageSize = 30;
    var currentUser = AdminBaseController.userData.value;

/*    var startDate = DateTime.now()
        .subtract(Duration(days: 365 * (userFilter.age?.start ?? 0)));
    var endDate = DateTime.now()
        .subtract(Duration(days: 365 * (userFilter.age?.end ?? 0)));
    Query<Map<String, dynamic>> snapShotQuery;*/

    var snapShot =
        await FirebaseFirestore.instance.collection(UserModel.TABLE_NAME);
    /*       .where('isBlocked', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);*/

    var qerysnapShot = await snapShot.limit(pageSize).get();
    var myId = AdminBaseController.userData.value.uid;
    var connectionStatus = AdminBaseController.userData.value.connectionStatus;
    print("started");

    var filterItem = qerysnapShot.docs
        .map((e) {
          return UserModel.fromJson(e.data());
        })

        //for Age Filter
        .where((element) =>
            element.age > userFilter.age!.start! &&
            element.age <= userFilter.age!.end!)

        // for filtering myProfile
        .where((element) => element.uid != myId)

        // for filtering already liked and dislike users
        .where((element) =>
            !currentUser.isLiked(element.uid!) &&
            !currentUser.isDisLiked(element.uid!) &&
            !currentUser.isMatched(element.uid!))

        // for filtering Connection Status
        .where((element) => element.connectionStatus == connectionStatus)
        .toList();
    if (currentUser.connectionStatus == 1) {
      filterItem = filterItem
          .where((element) => element.myGender == currentUser.myGender)
          .toList();
    } else {
      // for filtering gender
      filterItem = filterItem
          .where((element) =>
              userFilter.interestedIn == (element.myGender ?? false))
          .toList();
    }
    print('UseLocation>>>${userFilter.useLocation}');
    if (userFilter.useLocation ?? true) {
      // for filtering Distance
      filterItem = filterItem
          .where((element) => element.distance < userFilter.distance!)
          .toList();
    }

    if (filterItem.isEmpty && qerysnapShot.docs.length == pageSize) {
      return await getHomeUsers(userFilter);
    }

    return filterItem;
  }

  //******************************************************************************
  static Future<void> sendPasswordResetEmail(String email) async {
    //******************************************************************************
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AppException(e.message);
    }
  }

  static Future<void> likeUser(
      UserModel liker, UserModel likee, BuildContext context) async {
    final _baseController = BaseController(context, () {});
    var isMatch = likee.isLiked(liker.uid!);
    print('start like process');

    if (isMatch) {
      print('liked Profile');
      _baseController.showProgress();
      await FirebaseFirestore.instance
          .collection(UserModel.TABLE_NAME)
          .doc(liker.uid)
          .update({
        "myLikes": FieldValue.arrayRemove([likee.uid]),
        "otherLikes": FieldValue.arrayRemove([likee.uid]),
        "matches": FieldValue.arrayUnion([likee.uid]),
      });
      await FirebaseFirestore.instance
          .collection(UserModel.TABLE_NAME)
          .doc(likee.uid)
          .update({
        "myLikes": FieldValue.arrayRemove([liker.uid]),
        "otherLikes": FieldValue.arrayRemove([liker.uid]),
        "matches": FieldValue.arrayUnion([liker.uid]),
      });
      await createNewThread(liker, likee, null);
      print('end like process');
      _baseController.hideProgress();
      return;
    }
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(liker.uid)
        .update({
      "myLikes": FieldValue.arrayUnion([likee.uid]),
    });
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(likee.uid)
        .update({
      "otherLikes": FieldValue.arrayUnion([liker.uid]),
    });
    var userModel = await NetWorkServices.getUserDetail();
    if (userModel != null) {
      AdminBaseController.updateUser(userModel);
    }
  }

  static Future<List<StoryModel>> getStoryById(String uid) async {
    List<StoryModel> list = [];
    print('Start STory Function>>>>>>>>');
    try {
      var document = await FirebaseFirestore.instance
          .collection(StoryModel.TABLE_NAME)
          .where('sender_id', isEqualTo: uid)
          .get();
      if (document.docs.isNotEmpty) {
        list = document.docs
            .map((e) {
              var storyModel = StoryModel.fromJson(e.data());
              print('StoryModel>>>$storyModel');
              return storyModel;
            })
            .where(
                (element) => (element.storyTime!.toDate().isNotCompletedCycle))
            .toList();
        var userModel = await UserModel.getUserDetail(uid);
        if (userModel != null) {
          list = list.map((e) {
            e.userDetail = userModel;
            return e;
          }).toList();
        }
      }
    } catch (e) {
      print('Error Catch');
      print(e);
    }

    return list;
  }

  static Future<void> followUser(UserModel liker, UserModel likee) async {
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(likee.uid)
        .update({
      "followers": FieldValue.arrayUnion([liker.uid]),
    });
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(liker.uid)
        .update({
      "following": FieldValue.arrayUnion([likee.uid]),
    });
    var userModel =
        await UserModel.getUserDetail(AdminBaseController.userData.value.uid!);
    if (userModel != null) {
      AdminBaseController.updateUser(userModel);
    }
  }

  static Future<void> disLikeUser(UserModel liker, UserModel likee) async {
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(liker.uid)
        .update({
      "myLikes": FieldValue.arrayRemove([likee.uid]),
      "matches": FieldValue.arrayRemove([likee.uid]),
      "otherLikes": FieldValue.arrayRemove([likee.uid]),
    });
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(likee.uid)
        .update({
      "otherLikes": FieldValue.arrayRemove([liker.uid]),
      "matches": FieldValue.arrayRemove([liker.uid]),
      "myLikes": FieldValue.arrayRemove([liker.uid]),
    });
  }

  static Future<void> createNewThread(
      UserModel liker, UserModel likee, String? message) async {
    var threadId = createThreadId(likee.uid!, liker.uid!);
    var snapShot = await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .get();
    print("checking thread $threadId");
    if (snapShot.exists) return;
    print("created new thread");

    var thread = ThreadModel()
      ..threadId = threadId
      ..lastMessage = message
      ..lastMessageTime = Timestamp.now()
      ..senderId = liker.uid ?? ""
      ..participantUserList = [liker.uid ?? "", likee.uid ?? ""]
      ..messageCount = 1;
    await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .set({...thread.toJson(), "is_pending": message == null ? false : true},
            SetOptions(merge: true));
    if (message == null) {
      return;
    }
    ChatModel chatModel = ChatModel()
      ..id = generateRandomString(10)
      ..senderId = liker.uid ?? ""
      ..message = thread.lastMessage
      ..messageTime = Timestamp.now();
    await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .collection(ThreadModel.TABLE_NAME)
        .doc(chatModel.id)
        .set(chatModel.toJson(), SetOptions(merge: true));
  }

  static Future<void> sendMatchNotification(
      UserModel liker, UserModel likee) async {
    var notification = NotificationModel()
      ..id = generateRandomString(15)
      ..title = 'New Match'
      ..body = "You got a Match with ${liker.name}"
      ..receiverIds = [likee.uid!]
      ..senderId = liker.uid
      ..timestamp = Timestamp.now();
    print(notification.toJson());
    await FirebaseFirestore.instance
        .collection(NotificationModel.TABLE_NAME)
        .doc(notification.id)
        .set(notification.toJson(), SetOptions(merge: true));
    await showOkAlertDialog(
        context: Get.context!,
        title: 'Congrats',
        message: "You got a match with ${likee.name}");
  }

  static Future<List<UserModel>> getOtherLikes(UserModel userData) async {
    var snapShot = await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .where("my_likes", arrayContains: userData.uid)
        .get();
    print(snapShot.docs);
    return snapShot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  static Future<List<UserModel>> loadMataches(UserModel userModel) async {
    var snapShot = await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .where("matches", arrayContains: userModel.uid)
        .get();
    return snapShot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  static Future<void> setUserStatus(int status) async {
    var uid = AdminBaseController.userData.value.uid;
    FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(uid)
        .update({
      'chatStatus': status,
      'lastActive': Timestamp.now(),
    });
  }

  static Future<List<String>> loadOption(String tableName) async {
    List<OptionModel> optionList = [];
    var documents =
        await FirebaseFirestore.instance.collection(tableName).get();
    if (documents.docs.isNotEmpty) {
      optionList =
          documents.docs.map((e) => OptionModel.fromJson(e.data())).toList();
    }
    return optionList.map((e) => e.value ?? '').toList();
  }

  static Future<void> updateIsDate(bool status) async {
    var userModel = AdminBaseController.userData.value;
    userModel.isDate = status;
    userModel.addNewUserOrUpdate();
    AdminBaseController.updateUser(userModel);
  }

  static Future<void> updateMemberShip(int memberType, String uid) async {
    var user = AdminBaseController.userData.value;
    if (memberType != UserModel.MEMBER_PREMIUM_NON &&
        user.updatedTime != null &&
        user.memberShipType == memberType) {
      return;
    }
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(uid)
        .set({
      "member_ship_type": memberType,
      // "total_stars": UserModel.STARS[memberType],
      "updatedTime":
          memberType == UserModel.MEMBER_PREMIUM_NON ? null : Timestamp.now()
    }, SetOptions(merge: true));
  }

  //*******************************************************************
  static Future<void> blockUserAndUnBlock(
      UserModel receiverDetail, ThreadModel threadModel) async {
    //*******************************************************************
    if (threadModel.isBlocked ?? false) {
      await UnblockUser(receiverDetail, threadModel);
      Get.back();
      return;
    }
    var result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: 'Block User',
        message: 'Do you really want to block?',
        okLabel: 'Yes',
        cancelLabel: 'No');
    print(result);
    if (result == OkCancelResult.cancel) return;
    await NetWorkServices.blockUser(receiverDetail, threadModel);
    Get.back();
  }

  static Future<void> blockUser(
      UserModel receiverDetail, ThreadModel threadModel) async {
    var uid = AdminBaseController.userData.value.uid;
    await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadModel.threadId!)
        .set({
      "is_blocked": true,
      "sender_id": uid,
      "last_message": 'Block',
      "last_message_time": Timestamp.now()
    }, SetOptions(merge: true));
  }

  static Future<void> UnblockUser(
      UserModel receiverDetail, ThreadModel threadModel) async {
    var uid = AdminBaseController.userData.value.uid;
    await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadModel.threadId!)
        .set({
      "is_blocked": false,
      "sender_id": uid,
      "last_message": 'Unblock',
      "last_message_time": Timestamp.now()
    }, SetOptions(merge: true));
  }

  static Future<void> deleteConversation(
      ThreadModel threadModel, String threadId, String receiver_id) async {
    var uid = AdminBaseController.userData.value.uid;
/*    await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .delete();*/

    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .collection(ThreadModel.TABLE_NAME);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .delete();
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(uid)
        .set({
      "my_likes": FieldValue.arrayRemove([receiver_id]),
      "my_super_likes": FieldValue.arrayRemove([receiver_id]),
      "my_dislikes": FieldValue.arrayRemove([receiver_id]),
      "other_likes": FieldValue.arrayRemove([receiver_id]),
      "other_super_likes": FieldValue.arrayRemove([receiver_id]),
      "other_dislikes": FieldValue.arrayRemove([receiver_id])
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(receiver_id)
        .set({
      "my_likes": FieldValue.arrayRemove([uid]),
      "my_super_likes": FieldValue.arrayRemove([uid]),
      "my_dislikes": FieldValue.arrayRemove([uid]),
      "other_likes": FieldValue.arrayRemove([uid]),
      "other_super_likes": FieldValue.arrayRemove([uid]),
      "other_dislikes": FieldValue.arrayRemove([uid])
    }, SetOptions(merge: true));

    /*
        .set({
      "is_blocked": threadModel.isBlocked,
      "is_pending": threadModel.isPending,
      "sender_id": uid,
      "participant_user_list": FieldValue.arrayUnion([uid, receiver_id]),
      "thread_id": threadId,
      "last_message": AppLanguages.CONVERSATION_DELETED,
      "last_message_time": Timestamp.now(),
      "message_count": 1,
    }, SetOptions(merge: true));*/
  }

/*  static Future<String?> changePassword() async {
    var inputs = await showTextInputDialog(
        context: Get.context!,
        title: AppLanguages.CHANGE_PASSWORD,
        textFields: [
          DialogTextField(
              hintText: AppLanguages.OLD_PASSWORD,
              obscureText: true,
              validator: (password) {
                if (password?.isEmpty ?? true) {
                  return AppLanguages.PASSWORD_IS_REQUIRED;
                }
                if (password!.length < 8) {
                  return AppLanguages.PASSWORD_LENGTH_REQUIRED;
                }
              }),
          DialogTextField(
              obscureText: true,
              hintText: AppLanguages.NEW_PASSWORD,
              validator: (password) {
                if (password?.isEmpty ?? true) {
                  return AppLanguages.PASSWORD_IS_REQUIRED;
                }
                if (password!.length < 8) {
                  return AppLanguages.PASSWORD_LENGTH_REQUIRED;
                }
              })
        ]);
    print(inputs);

    if (inputs == null ||
        inputs.isEmpty ||
        inputs[0].isEmpty ||
        inputs[1].isEmpty) return "";
    try {
      var email = AdminBaseController.userData.value.email!;
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: inputs[0]);

      await FirebaseAuth.instance.currentUser!.updatePassword(inputs[1]);
      await showOkAlertDialog(
          context: Get.context!,
          title: "Update Password",
          message: "Password updated");
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }*/

/*  static Future<String?> deleteAccount() async {
    var userDetail = AdminBaseController.userData.value;

    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'deleteUser',
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 5),
        ),
      );
      final result = await callable.call(<String, dynamic>{
        'uid': userDetail.uid ?? "",
      });
      print(result.data.toString());
      if (result.data.toString().contains("error")) {
        return "Error";
      }
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }

    await NotificationUtils.fcmUnSubscribe();

    var userID = userDetail.uid;
    await deleteFile(userDetail.profileImage ?? "");
    for (var image in userDetail.images ?? []) {
      await deleteFile(image.toString());
    }

    await FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(userID)
        .set({
      "is_deleted": true,
      "first_name": "User",
      "last_name": "Deleted",
      "deleted_on": Timestamp.now(),
      "images": [],
      "my_likes": [],
      "profile_image":
          "https://firebasestorage.googleapis.com/v0/b/ever-love.appspot.com/o/574748-200.png?alt=media&token=a64e586f-37be-493c-a042-681f9b8f5364",
      "my_dislikes": [],
      "my_super_likes": []
    }, SetOptions(merge: true));
    await FirebaseAuth.instance.signOut();

    return null;
  }*/

  static Future<void> reportUserMessaagesORGroup(
      String messageId, int reportType, String message, String filePath) async {
    print(messageId);
    ReportMessageModel reportMessageModel = ReportMessageModel()
      ..id = messageId.replaceAll("/", "__")
      // ..sender_id = AdminBaseController.userData.value.uid
      ..type = reportType
      // ..reported_userid = chatModel.senderId
      ..report_time = Timestamp.now()
      // ..messages = message
      ..filePath = filePath
      ..message_id = messageId;
    await FirebaseFirestore.instance
        .collection(ReportMessageModel.TABLE_NAME)
        .doc((reportMessageModel.id ?? "").replaceAll("/", "__"))
        .set({
      ...reportMessageModel.toMap(),
      /* "sender_id":
          FieldValue.arrayUnion([AdminBaseController.userData.value.uid]),
      "reported_userid":
          FieldValue.arrayUnion([AdminBaseController.userData.value.email]),*/
      "messages": FieldValue.arrayUnion([
        "${AdminBaseController.userData.value?.uid ?? ""}-***-$message-***-${AdminBaseController.userData.value?.email ?? ""}"
      ])
    }, SetOptions(merge: true));
  }

  static Future<void> reportUser(UserModel userModel) async {
    var option1 = "Fake profile";
    var option2 = "Selling/scamming content";
    var option3 = "Nudity/sexual content";
    var option4 = "Abusive/Threatening content";
    var option5 = "Suspect under aged (18)";
    var options = await showConfirmationDialog(
        context: Get.context!,
        title: "Please select option",
        actions: [
          AlertDialogAction(label: option1, key: option1),
          AlertDialogAction(label: option2, key: option2),
          AlertDialogAction(label: option3, key: option3),
          AlertDialogAction(label: option4, key: option4),
          AlertDialogAction(label: option5, key: option5),
        ]);
    if (options == null) return;

    /* var texts = await showTextInputDialog(
        title: AppLanguages.REPORT_USER,
        context: Get.context!,
        textFields: [
          DialogTextField(
              initialText: AppLanguages.REPORT_USER_MESSAGE +
                  " " +
                  (userModel?.email ?? "") +
                  "\n",
              maxLines: 5,
              validator: (data) {
                if (data?.isEmpty ?? true) {
                  AppLanguages.REQUIRED;
                }
                return null;
              })
        ]);
*/
    print(options);
    /*if (texts == null || texts[0] == null) return;
    */
    options = "${userModel.email ?? ""}\n${options}";
    var messageId = "${UserModel.TABLE_NAME}/${userModel.uid ?? ""}";
    NetWorkServices.reportUserMessaagesORGroup(
        messageId, ReportMessageModel.USER_REPORT, options, "");
    showOkAlertDialog(
        context: Get.context!,
        title: 'Report User',
        message: 'User has been Reported successfully');
  }
}

//******************************************************************************
class AppException implements Exception {
  //******************************************************************************

  String? error;

  AppException(this.error);
}

//****************************************************************
void navigateToScreen(int flow) async {
  //****************************************************************

  switch (NavigationType.values[flow]) {
    case NavigationType.NAME_FLOW:
      Get.offAll(NameScreen());
      break;
    case NavigationType.GENDER_FLOW:
      Get.offAll(GenderScreen());
      break;
    case NavigationType.BIRTH_FLOW:
      Get.offAll(BirthScreen());
      break;
    case NavigationType.MODE_FLOW:
      Get.offAll(ModeScreen());
      break;
    case NavigationType.PICTURE_FLOW:
      Get.offAll(PictureScreen());
      break;
    case NavigationType.INTEREST_FLOW:
      Get.offAll(InterestScreen());
      break;
    case NavigationType.DESCRIBE_FLOW:
      Get.offAll(DescribeScreen());
      break;
    case NavigationType.LOCATION_FLOW:
      Get.offAll(LocationScreen());
      break;
    case NavigationType.SWIPE:
      Get.offAll(NavBarScreen());
      break;
    default:
      {
        if (AdminBaseController.userData.value.isBlocked ?? false) {
          showOkAlertDialog(
              context: Get.context!,
              title: 'Error',
              message: 'Your Account is Blocked by Admin');

          return;
        }
        /*  if ((!await Permission.location.isGranted) ||
              (!await Permission.locationWhenInUse.serviceStatus.isEnabled)) {
            Get.offAll(LocationPermissionScreen());
            return;
          }*/

        Get.offAll(NavBarScreen());
      }
  }
}

enum NavigationType {
  NAME_FLOW,
  GENDER_FLOW,
  BIRTH_FLOW,
  MODE_FLOW,
  PICTURE_FLOW,
  INTEREST_FLOW,
  DESCRIBE_FLOW,
  LOCATION_FLOW,
  SWIPE,
}
