import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';
import 'package:bematched/utils/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/base_controller.dart';
import '../../../widgets/custom_dailogs.dart';
import '../../admin_base_controller.dart';
import '../flow4_mode_screen/mode_screen.dart';

class BirthScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  DateTime? selectedDate;

  void setDOB() {
    if (selectedDate == null) {
      CustomDailogs.okErrorAlertDialog(
          Get.context!, 'Date of Birth is Required');
      return;
    }
    if (selectedDate!.isNotEighteenPlus) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Under 18 is not allowed');
      return;
    }

    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 3
        ..dob = Timestamp.fromDate(selectedDate!);
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => ModeScreen(isBack: true),
          transition: Transition.rightToLeft);
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
