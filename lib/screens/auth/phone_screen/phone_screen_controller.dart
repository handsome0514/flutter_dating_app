import 'dart:developer';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../network_service/network_services.dart';
import '../../../utils/base_controller.dart';
import '../../admin_base_controller.dart';
import '../otp_screen/otp_screen.dart';

//*******************************************************************

class PhoneScreenController extends GetxController {
  //*******************************************************************

  final _baseController = BaseController(Get.context!, () {});
  String dailCode = '';
  String phoneNumber = '';
  String verificationId = '';

  void goToOTPScreen() async {
    _baseController.dismissKeyBoard();
    if (dailCode.isEmpty) {
      showOkAlertDialog(
        context: Get.context!,
        title: 'Error',
        message: 'Please Select Country Code',
      );
      return;
    }
    if (phoneNumber.isEmpty || (dailCode.length + phoneNumber.length) != 13) {
      log('PhoneNumber $phoneNumber');
      showOkAlertDialog(
        context: Get.context!,
        title: 'Error',
        message: 'PLease Enter Valid Number',
      );
      return;
    }
    try {
      await verifyPhoneNumber((dailCode + phoneNumber));
    } catch (e) {
      log('exeptions');
      log(e.toString());
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _baseController.showProgress();
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (Platform.isAndroid) {
          var user = await auth.signInWithCredential(credential);
          log('Auth Completed');
          log(user.toString());
          UserModel? userModel = await NetWorkServices.getUserDetail();
          _baseController.hideProgress();
          if (userModel == null) {
            log("userModel null");
            userModel = UserModel();
            log(user.additionalUserInfo!.profile!['email']);
            userModel = userModel
              ..uid = user.user!.uid
              ..email = user.additionalUserInfo!.profile!["email"]
              ..phoneNumber = phoneNumber;
            AdminBaseController.updateUser(userModel);
            userModel.addNewUserOrUpdate();
          } else {
            log("usernot null");
            _baseController.hideProgress();
            AdminBaseController.updateUser(userModel);
          }
          navigateToScreen(userModel.flow ?? 0);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        _baseController.hideProgress();
        log('ExceptionCode: ${e.code}');
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
          showOkAlertDialog(
            context: Get.context!,
            title: 'Error',
            message: 'The provided phone number is not valid.',
          );
          return;
        }
        if (e.code == 'too-many-requests') {
          log('SMS Verification Error');
          showOkAlertDialog(
            context: Get.context!,
            title: 'SMS Verification Error',
            message:
                'You have attempted too many requests.Please try again later',
          );
          return;
        }
        log('code');
        log(e.code);
      },
      codeSent: (String verificationId, int? resendToken) async {
        log('verificationId: $verificationId');
        log('reSendToken: $resendToken');
        _baseController.hideProgress();
        Get.to(() => OtpScreen(
              verificationId: verificationId,
              resendToken: resendToken,
              phoneNumber: phoneNumber,
            ));
        /* String smsCode = 'xxxx';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        await auth.signInWithCredential(credential);*/
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
