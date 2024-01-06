import 'package:bematched/config.dart';
import 'package:bematched/screens/auth/flow5_picture_screen/picture_screen.dart';
import 'package:bematched/utils/base_controller.dart';

import '../../admin_base_controller.dart';

class ModeScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  List modeList = ['Date', 'BFF', 'BIZZ'];

  Rx<int> selectedMode = Rx(0);

  void setMode() {
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 4
        ..connectionStatus = selectedMode.value;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => PictureScreen(isBack: true),
          transition: Transition.rightToLeft);
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
