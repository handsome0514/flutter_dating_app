import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import 'change_password_screen_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordScreenController _controller =
      Get.put(ChangePasswordScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 17, right: 17, top: 20, bottom: 66),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Old Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: AppColors.DARK_BLUE,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        onChanged: (val) => _controller.oldPassword = val,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.DARK_BLUE,
                        ),
                        obscureText: _controller.hideOldPassword.value,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              _controller.hideOldPassword.value =
                                  !_controller.hideOldPassword.value;
                            },
                            child: Icon(
                              _controller.hideOldPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.DARK_BLUE.withOpacity(.7),
                            ),
                          ),
                          hintText: 'Please enter current Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.DARK_BLUE,
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 14, bottom: 14, left: 16, right: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: AppColors.DARK_BLUE,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        onChanged: (val) => _controller.newPassword = val,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.DARK_BLUE,
                        ),
                        obscureText: _controller.hideNewPassword.value,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              _controller.hideNewPassword.value =
                                  !_controller.hideNewPassword.value;
                            },
                            child: Icon(
                              _controller.hideNewPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.DARK_BLUE.withOpacity(.7),
                            ),
                          ),
                          hintText: 'Please enter new Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.DARK_BLUE,
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 14, bottom: 14, left: 16, right: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: AppColors.DARK_BLUE,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        onChanged: (val) => _controller.confirmPassword = val,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.DARK_BLUE,
                        ),
                        obscuringCharacter: '*',
                        obscureText: _controller.hideConfirmPassword.value,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              _controller.hideConfirmPassword.value =
                                  !_controller.hideConfirmPassword.value;
                            },
                            child: Icon(
                              _controller.hideConfirmPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.DARK_BLUE.withOpacity(.7),
                            ),
                          ),
                          hintText: 'Please enter confirm Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.DARK_BLUE,
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 14, bottom: 14, left: 16, right: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                                color: AppColors.themeColor, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 37),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _controller.updatePassword,
                      child: Container(
                        padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.themeColor,
                        ),
                        child: const Center(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
