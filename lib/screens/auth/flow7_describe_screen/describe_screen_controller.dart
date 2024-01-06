import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';

import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/widgets/custom_dailogs.dart';

import '../../admin_base_controller.dart';
import '../flow8_lcoation_screen/location_screen.dart';

class DescribeScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});

  String description = '';

  void setDescription() {
    if (description.isEmpty) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Please write something about yourself');
      return;
    }
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 7
        ..bios = description;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => LocationScreen(isBack: true));
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
