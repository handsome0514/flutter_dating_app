import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';
import 'package:bematched/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/thread_model.dart';
import '../models/user_model.dart';
import '../network_service/network_services.dart';
import '../screens/chat_screen/chat_screen_controller.dart';
import '../screens/welcome_screen/welcome_screen.dart';
import '../utils/app_utils.dart';

class CustomDailogs {
  static Future<void> okErrorAlertDialog(
      BuildContext context, String description) async {
    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ), //this right here
            insetPadding: const EdgeInsets.only(left: 19, right: 19),
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  const Icon(Icons.error,
                      color: AppColors.themeColor, size: 36),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: Get.back,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 18, bottom: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.themeColor,
                      ),
                      child: const Center(
                        child: Text(
                          'ok',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: AppFonts.INTER_BOLD,
                              color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> okSuccessAlertDialog(
      BuildContext context, String description) async {
    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ), //this right here
            insetPadding: const EdgeInsets.only(left: 19, right: 19),
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  const Icon(Icons.verified,
                      color: AppColors.themeColor, size: 36),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: Get.back,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 18, bottom: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.themeColor,
                      ),
                      child: const Center(
                        child: Text(
                          'ok',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: AppFonts.INTER_BOLD,
                              color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> disableDateMode(
      BuildContext context, Function()? onPressed) async {
    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ), //this right here
            insetPadding: const EdgeInsets.only(left: 19, right: 19),
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  SvgPicture.asset(SvgAssets.SAFETY_ICON),
                  const SizedBox(height: 16),
                  const Text(
                    'Are you sure you want to turn off Date Mode?',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      InkWell(
                        onTap: onPressed,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.themeColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.themeColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> logoutAccount(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ), //this right here
            insetPadding: const EdgeInsets.only(left: 19, right: 19),
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  SvgPicture.asset(SvgAssets.SAFETY_ICON),
                  const SizedBox(height: 16),
                  const Text(
                    'Are you sure you want to logout your account ?',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          Get.back();
                          FirebaseAuth auth = FirebaseAuth.instance;
                          await auth.signOut().then((value) async {
                            await Get.offAll(() => const WelcomeScreen());
                            Get.deleteAll();
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.themeColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.themeColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> deleteAccount(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ), //this right here
            insetPadding: const EdgeInsets.only(left: 19, right: 19),
            child: Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  SvgPicture.asset(SvgAssets.SAFETY_ICON),
                  const SizedBox(height: 16),
                  const Text(
                    'Are you sure you want to delete your account ?',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.themeColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: Get.back,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.themeColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> userDetail(BuildContext context,
      {required UserModel userModel}) async {
    showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 23, bottom: 33.5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xffF2F2F2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      await NetWorkServices.reportUser(userModel);
                      Get.back();
                      await showOkAlertDialog(
                          context: Get.context!,
                          title: 'Successfully',
                          message:
                              'User is Reported.we will take action as soon as possible');

                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Center(
                        child: Text(
                          'Report ${userModel.name ?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.BLACK,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> chatDetailBox(BuildContext context,
      {required ThreadModel threadModel}) async {
    showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 23, bottom: 33.5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xffF2F2F2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      var result = await showOkCancelAlertDialog(
                          context: Get.context!,
                          title: 'Chat',
                          message: 'Are you really want to delete the chat?',
                          okLabel: 'Yes',
                          cancelLabel: 'No');
                      if (OkCancelResult.ok.index == result.index) {
                        ThreadModel.deleteMessages(threadModel.threadId ?? "");
                        final ctrl = Get.find<ChatScreenController>();
                        ctrl.messageList.value = [];
                        ctrl.update(['body']);
                        print('******************deleted Chat');
                        Get.back();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Center(
                        child: Text(
                          'Cleat Chat',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.INTER_REGULAR,
                              color: AppColors.BLACK),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: .5,
                    color: const Color(0xffB2B2B2).withOpacity(.5),
                  ),
                  InkWell(
                    onTap: () async {
                      await NetWorkServices.blockUserAndUnBlock(
                          threadModel.userDetail!, threadModel);
                      final ctrl = Get.find<ChatScreenController>();
                      ctrl.update();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Center(
                        child: Text(
                          '${threadModel.isBlocked ?? false ? 'Unblock' : 'Block'} ${threadModel.userDetail?.name ?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: .5,
                    color: const Color(0xffB2B2B2).withOpacity(.5),
                  ),
                  InkWell(
                    onTap: () async {
                      await NetWorkServices.reportUser(threadModel.userDetail!);
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Center(
                        child: Text(
                          'Report ${threadModel.userDetail?.name ?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.BLACK,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<List<File>> photo_picker(BuildContext context,
      {int? maxPhoto}) async {
    List<File> pathList = [];
    pathList = (await showModalBottomSheet<List<File>>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.89,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 115,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                var images = await AppUtils.pickImages(
                                    source: Sources.Camera,
                                    pickItems: (maxPhoto ?? 1));
                                if (images.isNotEmpty) {
                                  Get.back(result: images);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 22.2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //  SvgPicture.asset(AppAsset.),
                                    SizedBox(width: 21),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                var images = await AppUtils.pickImages(
                                    source: Sources.Gallery,
                                    pickItems: (maxPhoto ?? 1));
                                if (images.isNotEmpty) {
                                  Get.back(result: images);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 22.2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //    SvgPicture.asset(AppAssets.IMAGE_ICON),
                                    SizedBox(width: 21),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 13.37),
                      GestureDetector(
                        onTap: () {
                          Get.back(result: <File>[]);
                        },
                        child: Container(
                          height: 57.21,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 13.37),
                    ],
                  ),
                ),
              );
            })) ??
        [];
    return pathList;
  }
}
