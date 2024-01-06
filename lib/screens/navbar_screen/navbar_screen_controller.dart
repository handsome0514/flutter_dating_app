import 'package:bematched/config.dart';
import 'package:bematched/models/thread_model.dart';
import 'package:bematched/network_service/network_services.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../models/option_model.dart';

class NavBarScreenController extends GetxController {
  Rx<int> selectedIndex = Rx(0);
  var userModel = AdminBaseController.userData.value;
  Rx<int> messageCount = Rx(0);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List navbarList = [
    {
      'active': SvgAssets.SELECTED_HOME_ICON,
      'inactive': SvgAssets.UNSELECTED_HOME_ICON,
    },
    {
      'active': SvgAssets.SELECTED_HEART_ICON,
      'inactive': SvgAssets.UNSELECTED_HEART_ICON,
    },
    {
      'active': SvgAssets.SELECTED_CHAT_ICON,
      'inactive': SvgAssets.UNSELECTED_CHAT_ICON,
    },
    {
      'active': SvgAssets.SELECTED_PROFILE_ICON,
      'inactive': SvgAssets.PROFILE_ICON,
    },
  ];

  void onSelection(int index) {
    selectedIndex.value = index;
  }

  void loadMessageCount() {
    FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .where('participant_user_list', arrayContains: userModel.uid ?? '')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        messageCount.value = 0;
        for (var doc in event.docs) {
          var user = ThreadModel.fromJson(doc.data());
          if (user.senderId == userModel.uid) continue;
          messageCount.value += user.messageCount ?? 0;
        }
      }
    });
  }

  void loadAllOptions() async {
    List<String> list = [];
    list = await NetWorkServices.loadOption(OptionList.heightOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateHeightOptions(list);
    }
    list =
        await NetWorkServices.loadOption(OptionList.educationLevelOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateEducationLevelOptions(list);
    }
    list = await NetWorkServices.loadOption(OptionList.drinkingOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateDrinkingOptions(list);
    }
    list = await NetWorkServices.loadOption(OptionList.smokingOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateSmokingOptions(list);
    }
    list = await NetWorkServices.loadOption(OptionList.relationshipOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateRelationShipOptions(list);
    }
    list = await NetWorkServices.loadOption(OptionList.zodiacSignOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateZodiacSignOptions(list);
    }
    list = await NetWorkServices.loadOption(OptionList.industryOption.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateIndustryOptions(list);
    }
    list = await NetWorkServices.loadOption(OptionList.yearsOfExperience.name);
    print('List>>>$list');
    if (list.isNotEmpty) {
      AdminBaseController.updateYearsOfExperienceOptions(list);
    }
  }

  @override
  void onInit() {
    loadMessageCount();
    loadAllOptions();
    NetWorkServices.setUserStatus(ChatStatus.online.index);
    SystemChannels.lifecycle.setMessageHandler((message) {
      print('Message>>>>$message');
      if (message?.contains('resumed') ?? false) {
        NetWorkServices.setUserStatus(ChatStatus.online.index);
      }
      if (message?.contains('paused') ?? false) {
        NetWorkServices.setUserStatus(ChatStatus.offline.index);
      }
      return Future.value(message);
    });
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    NetWorkServices.setUserStatus(ChatStatus.offline.index);
    // TODO: implement onClose
    super.onClose();
  }
}
