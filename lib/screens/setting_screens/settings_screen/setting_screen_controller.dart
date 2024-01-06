import 'package:bematched/config.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/welcome_screen/welcome_screen.dart';
import 'package:bematched/widgets/custom_dailogs.dart';

class SettingScreenController extends GetxController {
  var userModel = AdminBaseController.userData.value;
  Rx<bool> isDate = Rx(true);
  Rx<bool> sendPushNotifications = Rx(true);
  Rx<bool> newMessages = Rx(true);
  Rx<bool> newMatches = Rx(true);

  initData() {
    userModel = AdminBaseController.userData.value;
    isDate.value = userModel.isDate ?? true;
    update();
  }

  @override
  void onInit() {
    initData();
    // TODO: implement onInit
    super.onInit();
  }

  void signOut() {
    CustomDailogs.logoutAccount(Get.context!);
  }
}
