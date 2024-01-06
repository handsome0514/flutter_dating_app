import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/models/home_user_filter_model.dart';
import 'package:bematched/models/story_model.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/match_screen/match_screen.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/extension.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../config.dart';
import '../../network_service/network_services.dart';
import '../admin_base_controller.dart';

class HomeScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  CardSwiperController swiperController = CardSwiperController();
  List<UserModel> list = [];
  List<UserModel> followList = [];
  List<List<StoryModel>> storyList = [];

  List<String> tabList = ['BFF', 'DATE', 'BIZZ'];
  Rx<int> tabIndex = Rx(0);
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isFollowLoading = Rx(false);
  bool isStoryLoading = false;
  var userModel = AdminBaseController.userData.value;

  void createStory() async {
    var files = await CustomDailogs.photo_picker(Get.context!, maxPhoto: 1);
    if (files.isEmpty) return;
    _baseController.showProgress();
    var uid = generateRandomString(15);
    var url = await NetWorkServices.uploadImage(uid, files.first.path);
    uid = generateRandomString(15);
    var userId = AdminBaseController.userData.value.uid;
    StoryModel storyModel = StoryModel()
      ..id = uid
      ..fileUrl = url
      ..senderId = userId
      ..storyTime = Timestamp.now();

    storyModel.addNewUserOrUpdate();
    _baseController.hideProgress();
  }

  void loadStories() async {
    isStoryLoading = true;
    update(['story']);
    var userModel = AdminBaseController.userData.value;
    print('Following Length>>>${userModel.followers?.length}');
    storyList.clear();
    for (var uid in userModel.followers ?? []) {
      var list = await NetWorkServices.getStoryById(uid);
      print('After>>>>>>>>>>$list');
      if (list.isNotEmpty) {
        print('List>>>>>>>>>>$list');
        storyList.add(list);
      }
    }
    isStoryLoading = false;
    update(['story']);
  }

  void loadFollower() async {
    isFollowLoading.value = true;
    update(['follow']);
    var userModel = AdminBaseController.userData.value;
    followList.clear();
    var doc =
        await FirebaseFirestore.instance.collection(UserModel.TABLE_NAME).get();
    if (doc.docs.isNotEmpty) {
      var userList = doc.docs
          .map((e) => UserModel.fromJson(e.data()))
          .where((element) =>
              (element.firstRegister?.toDate() ?? DateTime.now()).withinTenDays)
          .where((element) =>
              !(userModel.following?.contains(element.uid) ?? false))
          .where((element) => element.uid != userModel.uid)
          .toList();
      if (userList.isNotEmpty) {
        followList.addAll(userList);
      }
      isFollowLoading.value = false;
      update(['follow']);
    }
  }

  void loadUser() async {
    //*******************************************************************

    try {
      var userFilter = HomeFilterModel.getUser();
      isLoading.value = true;
      update();
      log("calling");
      list = await NetWorkServices.getHomeUsers(userFilter);
      isLoading.value = false;
      log("*****************************************");
      log(list.toString());
      log("*****************************************");
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      log(e.toString());
    }
  }

  //*******************************************************************
  void likeUser(UserModel likee) async {
    //*******************************************************************
    try {
      log("like called");
      await NetWorkServices.likeUser(
          AdminBaseController.userData.value, likee, Get.context!);
      if (AdminBaseController.userData.value.matches!.contains(likee.uid)) {
        Get.to(() => MatchScreen(likee: likee),
            transition: Transition.rightToLeft);
        /* showOkAlertDialog(
            context: Get.context!,
            title: 'Match',
            message: 'You have got Matched.');*/
      }
    } on Exception catch (e) {
      log('error: $e');
    }
  }

  //*******************************************************************
  void disLikeUser(UserModel likee) async {
    //*******************************************************************

    log("dislike called");
    await NetWorkServices.disLikeUser(
        AdminBaseController.userData.value, likee);
  }

  @override
  void onInit() {
    loadStories();
    loadFollower();
    loadUser();

    // TODO: implement onInit
    super.onInit();
  }
}
