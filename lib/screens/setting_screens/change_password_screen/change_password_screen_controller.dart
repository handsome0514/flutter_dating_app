import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:get/get.dart';

import '../../../config.dart';

class ChangePasswordScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  Rx<bool> hideOldPassword = Rx(true);
  Rx<bool> hideNewPassword = Rx(true);
  Rx<bool> hideConfirmPassword = Rx(true);

  String oldPassword = '';

  String newPassword = '';
  String confirmPassword = '';

  void updatePassword() async {
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      CustomDailogs.okErrorAlertDialog(
          Get.context!, 'Empty field is not valid');

      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    _baseController.showProgress();

    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);
    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) async {
        print('Then>>>>');
        _baseController.hideProgress();
        await CustomDailogs.okSuccessAlertDialog(
            Get.context!, 'Your Password has been changed.');
        Get.back();
        return;
      }).whenComplete(() {
        print('Completed');
      }).catchError((error) {
        _baseController.hideProgress();
        print('object');
        CustomDailogs.okErrorAlertDialog(Get.context!, error.toString());
      });
    }).catchError((err) {
      _baseController.hideProgress();
      if (err.toString().contains('INVALID_LOGIN_CREDENTIALS')) {
        CustomDailogs.okErrorAlertDialog(
            Get.context!, 'Please enter correct password');
      } else {
        CustomDailogs.okErrorAlertDialog(Get.context!, err.toString());
      }
    });
  }
}
