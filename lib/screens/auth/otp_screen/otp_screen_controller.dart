import 'dart:async';
import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/user_model.dart';
import '../../../network_service/network_services.dart';
import '../../../utils/base_controller.dart';
import '../../admin_base_controller.dart';

class OtpScreenController extends GetxController {
  String phoneNumber = '';
  final BaseController _baseController = BaseController(Get.context, () {});
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  Rx<int> timer = 60.obs;

  @override
  void onInit() {
    scheduleTimer();
    super.onInit();
  }

  void scheduleTimer() {
    Timer.periodic(const Duration(seconds: 1), (time) async {
      if (timer.value == 0) {
        time.cancel();
        return;
      }
      timer.value--;
    });
  }

  Rx<String> otpString = Rx('');
  Rx<bool> isVerified = Rx(false);

  void verifyOTP(String verificationId) async {
    var auth = FirebaseAuth.instance;
    otpString.value =
        otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
    if (otpString.value.length != 6) {
      showOkAlertDialog(
        context: Get.context!,
        title: 'Error',
        message: 'Please enter valid OTP',
      );
      return;
    }

    log(otpString.value);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpString.value);
      var user = await auth.signInWithCredential(credential);

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
    } catch (e) {
      showOkAlertDialog(
        context: Get.context!,
        title: 'SMS Verification Error',
        message: e.toString(),
      );
      log('execption');
      log('Execption $e');
    }
  }

  void reSendOTP(
      String verificationId, int reSendToken, String phoneNumber) async {
    if (timer.value != 0) return;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      _baseController.showProgress();
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Verification Completed');
          _baseController.hideProgress();
          await auth.signInWithCredential(credential);
        },
        forceResendingToken: reSendToken,
        codeAutoRetrievalTimeout: (String codeverificationId) {
          codeverificationId = verificationId;
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
        codeSent: (String verificationId, int? forceResendingToken) {
          _baseController.hideProgress();
          timer.value = 60;
          scheduleTimer();
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
