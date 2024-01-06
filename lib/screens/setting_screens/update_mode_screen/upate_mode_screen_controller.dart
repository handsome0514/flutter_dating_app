import 'package:bematched/config.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/personal_profile_screen/personal_profile_screen_controller.dart';
import 'package:bematched/screens/setting_screens/settings_screen/setting_screen_controller.dart';
import 'package:bematched/utils/base_controller.dart';

import '../../home_screen/home_screen_controller.dart';

class UpdateModeScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  Rx<int> selectedIndex =
      Rx(AdminBaseController.userData.value.connectionStatus ?? 0);
  var userModel = AdminBaseController.userData.value;

  @override
  void onInit() {
    userModel = AdminBaseController.userData.value;
    // TODO: implement onInit
    super.onInit();
  }

  void updateMode() {
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel.connectionStatus = selectedIndex.value;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      final ctrl = Get.find<HomeScreenController>();
      ctrl.loadUser();
      final settCtrl = Get.find<SettingScreenController>();
      settCtrl.initData();
      final perCtrl = Get.find<PersonalProfileScreenController>();
      perCtrl.updateUserModel();
      _baseController.hideProgress();
      Get.back();
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
