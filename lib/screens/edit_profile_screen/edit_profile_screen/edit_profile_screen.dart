import 'dart:io';

import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/edit_profile_screen/edit_profile_screen/edit_profile_screen_controller.dart';
import 'package:bematched/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config.dart';
import '../../../utils/app_cache_image.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/profile_photos_widget.dart';
import '../../admin_base_controller.dart';
import '../../gallery_screen/gallery_screen.dart';
import '../verification_screen/verification_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final _controller = Get.put(EditProfileScreenController());

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
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            if (_controller.profilePath.isEmpty)
                              AppCacheImage(
                                imageUrl:
                                    _controller.userModel.value.profileImage ??
                                        '',
                                width: 90,
                                height: 90,
                                round: 45,
                                boxFit: BoxFit.cover,
                              )
                            else
                              Container(
                                height: 106,
                                width: 106,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(_controller.profilePath.value)),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            Positioned(
                              top: 5,
                              right: 0,
                              child: InkWell(
                                onTap: _controller.photoPicker,
                                child: const Icon(Icons.edit,
                                    color: AppColors.themeColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.verified_outlined,
                                color: AppColors.themeColor),
                            SizedBox(width: 6),
                            Text(
                              'Verify my Profile',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: AppFonts.INTER_MEDIUM,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  var user = AdminBaseController.userData.value;
                                  if (user.isVerified != 0) return;
                                  Get.bottomSheet(VerificationScreen(),
                                      isScrollControlled: true,
                                      persistent: false,
                                      enableDrag: false,
                                      isDismissible: false);
                                },
                                child: Text(
                                  AdminBaseController
                                              .userData.value.isVerified ==
                                          0
                                      ? 'Not Verified'
                                      : AdminBaseController
                                                  .userData.value.isVerified ==
                                              1
                                          ? 'Pending'
                                          : 'Verified',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.INTER_SEMIBOLD,
                                    color: Color(0xff9F9DA1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Transform.flip(
                              flipX: true,
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: Color(0xff9F9DA1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      'Name',
                      style: TextStyle(
                          color: AppColors.GREY,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintLabel: '',
                      initialValue: _controller.userModel.value.name,
                      onChanged: (val) =>
                          _controller.userModel.value.name = val,
                    ),
                    const SizedBox(height: 19),
                    const Text(
                      'Bio',
                      style: TextStyle(
                          color: AppColors.GREY,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintLabel: '',
                      maxLines: 4,
                      initialValue: _controller.userModel.value.bios,
                      onChanged: (val) =>
                          _controller.userModel.value.bios = val,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                          color: AppColors.GREY,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<EditProfileScreenController>(
                      builder: (controller) => InkWell(
                        onTap: _controller.datePicker,
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.WHITE,
                            border: Border.all(color: const Color(0xffD9D9D9)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _controller.userModel.value.dob!
                                      .toDate()
                                      .dd_mm_yyyy,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.GREY,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                  ),
                                ),
                                SvgPicture.asset(SvgAssets.CALENDER_ICON,
                                    fit: BoxFit.scaleDown),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Interest',
                      style: TextStyle(
                          color: AppColors.GREY,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<EditProfileScreenController>(
                      builder: (controller) => GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(0),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: (1 / .3),
                        children: List.generate(
                          interests.length,
                          (i) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _controller.selector(i),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: _controller.userModel.value.interest!
                                        .contains(i)
                                    ? AppColors.themeColor
                                    : Colors.white,
                                border:
                                    Border.all(color: const Color(0xFFD9D9D9)),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    interests[i]["icon"],
                                    color: _controller.userModel.value.interest!
                                            .contains(i)
                                        ? AppColors.whiteColor
                                        : AppColors.themeColor,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    interests[i]["text"],
                                    style: _controller.userModel.value.interest!
                                            .contains(i)
                                        ? const TextStyle(
                                            fontSize: 14,
                                            fontFamily: AppFonts.INTER_BOLD,
                                            color: AppColors.whiteColor,
                                          )
                                        : const TextStyle(
                                            fontSize: 14,
                                            fontFamily: AppFonts.INTER_REGULAR,
                                            color: AppColors.BLACK,
                                          ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ProfilePhotosWidget(
                      photosPattern: const [230.13, 204.13, 230.13, 204.13],
                      images: _controller.userModel.value.images ?? [],
                      seeAllClicked: () => Get.to(
                        () => GalleryScreen(
                          userModel: _controller.userModel.value,
                          isMyProfile: true,
                        ),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Location',
                      style: TextStyle(
                          color: AppColors.GREY,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      initialValue: _controller.userModel.value.location,
                      hintLabel: 'Location',
                      onChanged: (val) =>
                          _controller.userModel.value.location = val,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _controller.updateProfile,
                      child: Container(
                        padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.themeColor,
                        ),
                        child: const Center(
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
