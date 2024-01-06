import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';
import 'package:bematched/screens/auth/flow1_name_screen/name_screen.dart';
import 'package:bematched/utils/base_controller.dart';
import '../../../models/user_model.dart';
import '../../../network_service/network_services.dart';
import '../../../widgets/custom_dailogs.dart';

class SignUpScreenController extends GetxController {
  String email = '';
  String password = '';
  final _baseController = BaseController(Get.context!, () {});

  //****************************************************************
  void signUp() async {
    //****************************************************************

    if (email.isEmpty) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Email is Required');
      return;
    }
    if (password.isEmpty) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Password is Required');
      return;
    }
    if (password.length < 8) {
      CustomDailogs.okErrorAlertDialog(
          Get.context!, 'Password should be greater than 8 characters');
      return;
    }
    UserModel userModel = UserModel()
      ..email = email
      ..password = password
      ..flow = 0;

    try {
      _baseController.showProgress();
      var responseUser = await NetWorkServices.signupUser(userModel);
      log(responseUser.toString());
      _baseController.hideProgress();
      Get.offAll(() => NameScreen());
    } on AppException catch (e) {
      _baseController.hideProgress();
      CustomDailogs.okErrorAlertDialog(Get.context!, e.error.toString());
      return;
    }
    return;
  }
}
