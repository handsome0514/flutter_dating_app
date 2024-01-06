import 'package:bematched/config.dart';

import '../../../utils/base_controller.dart';
import '../../admin_base_controller.dart';
import '../flow3_birth_screen/birth_screen.dart';

class GenderScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  List<String> gender = ['Female', 'Male'];
  Rx<int> selectedGender = Rx(0);

  void setGender() {
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 2
        ..myGender = selectedGender.value;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => BirthScreen(isBack: true),
          transition: Transition.rightToLeft);
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
