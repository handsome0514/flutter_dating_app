import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';
import 'package:bematched/utils/base_controller.dart';

import '../../../widgets/custom_dailogs.dart';
import '../../admin_base_controller.dart';
import '../flow7_describe_screen/describe_screen.dart';

class InterestScreenController extends GetxController {
  final _baseController = BaseController(Get.context!, () {});
  RxList selectedInterests = RxList();

  void selector(int i) {
    if (selectedInterests.contains(i)) {
      selectedInterests.remove(i);
    } else {
      if (selectedInterests.length == 5) return;
      selectedInterests.add(i);
    }
  }

  void setInterest() {
    if (selectedInterests.isEmpty || selectedInterests.length != 5) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Please Select five Interest');
      return;
    }
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 6
        ..interest = selectedInterests;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => DescribeScreen(isBack: true));
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
