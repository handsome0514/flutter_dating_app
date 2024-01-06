import 'dart:developer';
import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:get/get.dart';
import '../../models/user_model.dart';
import '../../network_service/network_services.dart';
import '../../utils/base_controller.dart';
import '../../utils/extension.dart';
import '../admin_base_controller.dart';
import '../profile_screen/profile_screen_controller.dart';

//*******************************************************************
class GalleryScreenController
    extends GetxController //*******************************************************************
{
  var uploaded = [''].obs;
  var userModel = UserModel().obs;
  final _baseController = BaseController(Get.context!, () {});

  void showImagePicker() async {
    //*******************************************************************

    var files = await CustomDailogs.photo_picker(Get.context!);
    if (files.isNotEmpty) {
      _baseController.showProgress();
      for (var file in files) {
        await uploadImages(file);
      }

      _baseController.hideProgress();
      AdminBaseController.updateUser(userModel.value);
      update();
      final ctrl = Get.find<ProfileScreenController>();
      ctrl.userModel = userModel.value;
      ctrl.update();
    }
  }

  Future<void> uploadImages(File file) async {
    var url = await NetWorkServices.uploadUserImage(
        generateRandomString(15), file.path);
    log(url);
    userModel.value.images = userModel.value.images ?? [];
    userModel.value.images?.add(url);
    await userModel.value.addNewUserOrUpdate();
  }

  //*******************************************************************
  void deleteImages(String image) async {
    //*******************************************************************
    var result = await showOkCancelAlertDialog(
      context: Get.context!,
      title: 'Gallery',
      message: 'Do you really want delete',
      okLabel: 'Yes',
      cancelLabel: 'No',
    );
    if (result == OkCancelResult.cancel) {
      return;
    }
    _baseController.showProgress();
    var index =
        userModel.value.images?.indexWhere((element) => element == image) ?? 0;
    log(image);
    await NetWorkServices.deleteFile(image);
    userModel.value.images?.removeAt(index);
    await userModel.value.addNewUserOrUpdate();
    _baseController.hideProgress();
    AdminBaseController.updateUser(userModel.value);
    final ctrl = Get.find<ProfileScreenController>();
    ctrl.userModel = userModel.value;
    ctrl.update();
    update();
  }
}
