import 'dart:io';

import 'package:bematched/config.dart';
import 'package:bematched/screens/edit_profile_screen/verification_screen/verification_screen_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_button.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final _controller = Get.put(VerificationScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationScreenController>(
      builder: (controller) => Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.90),
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: controller.imagePath.isEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: Get.back, child: const Icon(Icons.close)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, right: 5),
                      height: 150,
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                            image:
                                AssetImage(ImageAssets.SELFIE_WITH_TWO_FINGERS),
                            fit: BoxFit.cover),
                      ),
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child:
                            Icon(Icons.verified, color: AppColors.themeColor),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Copy with pose and take a photo',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'We\'ll check this photo matches the person in your profile.It won\'t be visible on your profile.',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'To verify succesfully:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 6,
                                width: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.BLACK,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Your face must be clear visible.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppFonts.INTER_MEDIUM,
                                  color: AppColors.BLACK,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 6,
                                width: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.BLACK,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'You must be copying this pose exacly.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppFonts.INTER_MEDIUM,
                                  color: AppColors.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      buttonLabel: 'Take my Photo',
                      onTap: _controller.filePicker,
                    ),
                    const SizedBox(height: 35),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            _controller.imagePath = '';
                            _controller.update();
                          },
                          child: const Icon(Icons.arrow_back)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5, right: 5),
                          height: 150,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                                image: AssetImage(
                                    ImageAssets.SELFIE_WITH_TWO_FINGERS),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.only(bottom: 5, right: 5),
                          height: 150,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: FileImage(File(controller.imagePath)),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Review and save your photo',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.BLACK,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 7),
                                height: 6,
                                width: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.BLACK,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'beMatch will compare this photo with your profile photo, which may include the use of facial recognition.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: AppColors.BLACK,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 7),
                                height: 6,
                                width: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.BLACK,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'We\'ll keep your photo and scans to verify your photos in the future.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: AppColors.BLACK,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      buttonLabel: 'Agree and submit',
                      onTap: _controller.submit,
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      buttonLabel: 'Retake',
                      onTap: _controller.filePicker,
                      borderColor: AppColors.themeColor,
                      buttonColor: Colors.transparent,
                      textColor: AppColors.themeColor,
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
        ),
      ),
    );
  }
}
