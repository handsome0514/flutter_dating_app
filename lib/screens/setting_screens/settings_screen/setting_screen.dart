import 'dart:ffi';

import 'package:bematched/models/user_model.dart';
import 'package:bematched/network_service/network_services.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/auth/flow4_mode_screen/mode_screen.dart';
import 'package:bematched/screens/edit_profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/screens/setting_screens/help_screen/help_screen.dart';
import 'package:bematched/screens/setting_screens/settings_screen/setting_screen_controller.dart';
import 'package:bematched/screens/setting_screens/update_mode_screen/update_mode_screen.dart';
import 'package:bematched/screens/subscription_screen/subscription_screen.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:bematched/widgets/pdf_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../widgets/animated_container_switch.dart';
import '../change_password_screen/change_password_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final SettingScreenController _controller =
      Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: Get.back,
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.themeColor,
            size: 20,
          ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _controller.signOut,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(SvgAssets.LOGOUT_ICON),
            ),
          )
        ],
      ),
      body: GetBuilder<SettingScreenController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                      color: AppColors.BLACK,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Manage your settings for best app use',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: Color(0xff9F9DA1),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgAssets.ACCOUNT_ICON),
                      const SizedBox(width: 18),
                      const Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => EditProfileScreen(),transition: Transition.rightToLeft);
                  },
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.BLACK,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => ChangePasswordScreen(),
                        transition: Transition.rightToLeft);
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.BLACK,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgAssets.CONNECTION_ICON),
                      const SizedBox(width: 18),
                      const Text(
                        'Connection',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => UpdateModeScreen(),
                        transition: Transition.rightToLeft);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 19, bottom: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date Mode',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: AppColors.BLACK,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              connectionList.elementAt(
                                  _controller.userModel.connectionStatus ??
                                      0)['title'],
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: AppFonts.INTER_MEDIUM,
                                color: Color(0xff9F9DA1),
                              ),
                            ),
                            Transform.flip(
                              flipX: true,
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Color(0xff9F9DA1),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19, bottom: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date Mode',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: AppColors.BLACK,
                        ),
                      ),
                      Obx(
                        () => AnimatedContainerSwitch(
                          ison: _controller.isDate.value,
                          onChanged: (bool value) async {
                            if (value == false) {
                              await CustomDailogs.disableDateMode(context, () {
                                Get.back();
                                NetWorkServices.updateIsDate(value);
                                final ctrl = Get.find<HomeScreenController>();
                                ctrl.loadUser();
                                _controller.isDate.value = value;
                              });
                            } else {
                              NetWorkServices.updateIsDate(value);
                              final ctrl = Get.find<HomeScreenController>();
                              ctrl.loadUser();
                              _controller.isDate.value = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgAssets.NOTIFICATION_ICON),
                      const SizedBox(width: 18),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Send Push Notifications',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: AppFonts.INTER_MEDIUM,
                        color: AppColors.BLACK,
                      ),
                    ),
                    Obx(
                      () => AnimatedContainerSwitch(
                        ison: _controller.sendPushNotifications.value,
                        onChanged: (bool value) {
                          _controller.sendPushNotifications.value = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New Messages',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: AppFonts.INTER_MEDIUM,
                        color: AppColors.BLACK,
                      ),
                    ),
                    Obx(
                      () => AnimatedContainerSwitch(
                        ison: _controller.newMessages.value,
                        onChanged: (bool value) {
                          _controller.newMessages.value = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New Matched',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: AppFonts.INTER_MEDIUM,
                        color: AppColors.BLACK,
                      ),
                    ),
                    Obx(
                      () => AnimatedContainerSwitch(
                        ison: _controller.newMatches.value,
                        onChanged: (bool value) {
                          _controller.newMatches.value = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.to(() => SubScriptionScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgAssets.VIP_ICON),
                        const SizedBox(width: 18),
                        const Text(
                          'Manage Subscriptions',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*          const SizedBox(height: 17),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgAssets.PAYMENT_ICON),
                      const SizedBox(width: 18),
                      const Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),*/
                const SizedBox(height: 17),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      CustomDailogs.deleteAccount(context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgAssets.DELETE_ICON),
                        const SizedBox(width: 18),
                        const Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Divider(color: Color(0xffDFD2F3)),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.to(() => HelpScreen(),transition: Transition.rightToLeft);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgAssets.HELP_ICON),
                        const SizedBox(width: 18),
                        const Text(
                          'Help Center',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => PdfReader(
                          title: 'Terms & Conditions',
                          pdfUrl:
                              'https://firebasestorage.googleapis.com/v0/b/bematched-1e882.appspot.com/o/terms_and_conditions.pdf?alt=media&token=9fa89725-83d0-4018-8170-76286e926c4a',
                        ),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgAssets.TERM_ICON),
                        const SizedBox(width: 18),
                        const Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Get.to(
                            () => PdfReader(
                          title: 'Privacy Policy',
                          pdfUrl:
                          'https://firebasestorage.googleapis.com/v0/b/bematched-1e882.appspot.com/o/privacy_policy.pdf?alt=media&token=25593de1-a7f6-4cc4-b02a-7453e49ede3f',
                        ),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgAssets.PRIVACY_ICON),
                        const SizedBox(width: 18),
                        const Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
