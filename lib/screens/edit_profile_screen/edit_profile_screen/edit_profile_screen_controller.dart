import 'dart:developer';

import 'package:bematched/config.dart';
import 'package:bematched/screens/personal_profile_screen/personal_profile_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model.dart';
import '../../../network_service/network_services.dart';
import '../../../widgets/calender_bottomsheet.dart';
import '../../../widgets/custom_dailogs.dart';
import '../../admin_base_controller.dart';
import '../../profile_screen/profile_screen_controller.dart';

class EditProfileScreenController extends GetxController {
  Rx<UserModel> userModel = AdminBaseController.userData;
  Rx<String> profilePath = Rx('');

  void selector(int i) {
    if (userModel.value.interest!.contains(i)) {
      userModel.value.interest!.remove(i);
    } else {
      if (userModel.value.interest!.length == 5) return;
      userModel.value.interest!.add(i);
    }
    update();
  }

  void photoPicker() async {
    var files = await CustomDailogs.photo_picker(Get.context!, maxPhoto: 1);
    if (files.isNotEmpty) {
      profilePath.value = files.first.path;
    }
  }

  void datePicker() async {
    var date = await Get.bottomSheet(
      CalenderBottomSheet(),
      isScrollControlled: true,
      persistent: false,
    );
    log('Date>>>$date');
    if (date != null) {
      userModel.value.dob = Timestamp.fromDate(date);
      update();
    }
  }

  void updateProfile() async {
    if (profilePath.isNotEmpty) {
      var fileUrl = await NetWorkServices.uploadImage(
          userModel.value.uid ?? '', profilePath.value);
      await NetWorkServices.deleteFile(userModel.value.profileImage ?? '');
      userModel.value.profileImage = fileUrl;
    }
    userModel.value.addNewUserOrUpdate();
    AdminBaseController.updateUser(userModel.value);
    final ctrl = Get.find<PersonalProfileScreenController>();
    ctrl.updateUserModel();
    Get.back();
  }
}
