import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';

import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/home_user_filter_model.dart';
import '../../../models/user_model.dart';
import '../../../network_service/network_services.dart';
import '../../../utils/network_utils/NetworkUtils.dart';
import '../../admin_base_controller.dart';

class LoginScreenController extends GetxController {
  final _baseController = BaseController(Get.context!, () {});
  String email = '';
  String password = '';

  //****************************************************************
  void loginIntoTheApp() async {
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
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Password should be greater than 8 characters');
      return;
    }

    UserModel userModel = UserModel()
      ..email = email
      ..password = password;

    _baseController.showProgress();
    try {
      var userDetail = await NetWorkServices.loginUser(userModel);
      _baseController.hideProgress();
      HomeFilterModel.initFilter();
      if (userDetail == null) return;
      navigateToScreen(userDetail.flow ?? 0);
    } on AppException catch (e) {
      _baseController.hideProgress();
      CustomDailogs.okErrorAlertDialog(Get.context!, e.error??'Error');
    }
  }

  void loginWithFacebook() async {
    //*******************************************************************
    _baseController.showProgress();
    late UserCredential user;
    try {
      user = await signInWithFacebook();
    } on Exception catch (e) {
      _baseController.hideProgress();
      print(e);
      return;
    }

    print(user.additionalUserInfo!.profile.toString());
    UserModel? userModel = await NetWorkServices.getUserDetail();
    _baseController.hideProgress();
    if (userModel == null) {
      print("user null");
      userModel = UserModel()
        ..uid = FirebaseAuth.instance.currentUser!.uid
        ..profileImage = user
            .additionalUserInfo!.profile!["picture"]["data"]["url"]
            .toString()
        ..email = user.additionalUserInfo!.profile!["email"];

      AdminBaseController.updateUser(userModel);
    } else {
      print("usernot null");
      AdminBaseController.updateUser(userModel);
    }
    navigateToScreen(userModel.flow ?? 0);
    print(user);
  }

  //*******************************************************************
  void loginWIthGoogle() async {
    //*******************************************************************
    _baseController.showProgress();

    var user = await signInWithGoogle();
    if (user == null) {
      _baseController.hideProgress();
      return;
    }
    UserModel? userModel = await NetWorkServices.getUserDetail();
    _baseController.hideProgress();
    if (userModel == null) {
      print("user null");
      userModel = UserModel()
        ..uid = FirebaseAuth.instance.currentUser!.uid
        ..email = user.additionalUserInfo!.profile!["email"];
      AdminBaseController.updateUser(userModel);
    } else {
      print("usernot null");
      _baseController.hideProgress();
      AdminBaseController.updateUser(userModel);
    }
    navigateToScreen(userModel.flow ?? 0);
  }

  //**********************************************************
  Future<UserCredential?> signInWithGoogle() async {
    //**********************************************************
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if ((googleAuth?.accessToken ?? '').isEmpty ||
          (googleAuth?.idToken ?? '').isEmpty) {
        _baseController.hideProgress();
        return null;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print(e.toString());
      _baseController.hideProgress();
      return null;
    }
  }

  //**********************************************************
  Future<UserCredential> signInWithFacebook() async {
    //**********************************************************
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");

    var userCredentials = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    var api = await NetworkUtil.internal().get("",
        baseURL:
            "https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${loginResult.accessToken?.token ?? ""}");
    print(api);
    userCredentials.additionalUserInfo!.profile!["picture"]["data"]["url"] =
        api["picture"]["data"]["url"];
    return userCredentials;
  }
}
