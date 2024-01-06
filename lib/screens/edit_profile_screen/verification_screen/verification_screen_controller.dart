import 'dart:developer';

import 'package:bematched/config.dart';
import 'package:bematched/models/verification_model.dart';
import 'package:bematched/network_service/network_services.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/app_utils.dart';

class VerificationScreenController extends GetxController {
  final _baseController = BaseController(Get.context!, () {});
  String imagePath = '';

  void filePicker() async {
    var images =
        await AppUtils.pickImages(source: Sources.Camera, pickItems: 1);
    if (images.isNotEmpty) {
      imagePath = images.first.path;
      update();
    }
  }

  void submit() async {
    if (imagePath.isEmpty) return;
    var uid = generateRandomString(15);
    try {
      _baseController.showProgress();
      var url = await NetWorkServices.uploadImage(
          generateRandomString(15), imagePath);
      VerificationModel verificationModel = VerificationModel()
        ..userUid = AdminBaseController.userData.value.uid
        ..id = uid
        ..photoUrl = url
        ..gesture = 'hand up with two fingers';
      FirebaseFirestore.instance
          .collection(VerificationModel.TABLE_NAME)
          .doc(uid)
          .set(verificationModel.toJson());
      var userModel = AdminBaseController.userData.value;
      userModel.isVerified = 1;
      userModel.addNewUserOrUpdate();
      _baseController.hideProgress();
      Get.delete<VerificationScreenController>();
      Get.back();
    } catch (e) {
      _baseController.hideProgress();
      log(e.toString());
    }
  }
}
