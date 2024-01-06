import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:flutter/foundation.dart';

import '../flow2_gender_screen/gender_screen.dart';

class NameScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  String name = '';

  void setName() {
    if (name.isEmpty) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Name is Required');

      return;
    }
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 1
        ..name = name;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => GenderScreen(isBack: true));
    } catch (e) {
      _baseController.hideProgress();
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
