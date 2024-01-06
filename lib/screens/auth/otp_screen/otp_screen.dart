import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/otp_box.dart';
import 'otp_screen_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    super.key,
    required this.verificationId,
    this.resendToken,
    required this.phoneNumber,
  });

  final String verificationId;
  final int? resendToken;
  final String phoneNumber;
  final OtpScreenController _controller = Get.put(OtpScreenController());

  @override
  Widget build(BuildContext context) {
    _controller.phoneNumber = phoneNumber;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.only(left: 31, right: 31),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),
                      Image.asset(
                        ImageAssets.logo,
                        fit: BoxFit.scaleDown,
                        height: 31.33,
                        width: 128,
                        color: AppColors.DARK_BLUE,
                      ),
                      const SizedBox(height: 62.87),
                      const Text(
                        'Verify Your Number',
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.DARK_BLUE,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'AppLanguage.VERIFY_YOUR_NUMBER_DESCRIPTION',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.DARK_BLUE,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 42),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OtpBox(
                            index: '1',
                            controller: _controller.otp1,
                          ),
                          //  const SizedBox(width: 13),
                          OtpBox(
                            index: '2',
                            controller: _controller.otp2,
                          ),
                          //const SizedBox(width: 13),
                          OtpBox(
                            index: '3',
                            controller: _controller.otp3,
                          ),
                          // const SizedBox(width: 13),
                          OtpBox(
                            index: '4',
                            controller: _controller.otp4,
                          ),
                          OtpBox(
                            index: '5',
                            controller: _controller.otp5,
                          ),
                          OtpBox(
                            index: '6',
                            controller: _controller.otp6,
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Obx(() => _controller.isVerified.value
                          ? Container(
                              height: 38,
                              width: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.green.withOpacity(.1),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.verified),
                                  SizedBox(width: 6),
                                  Text(
                                    'Success',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.INTER_SEMIBOLD,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container()),
                      const Spacer(),
                      const SizedBox(height: 86.16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                const Text(
                                  'Resend',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppFonts.INTER_REGULAR,
                                    color: AppColors.BLACK,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                InkWell(
                                  onTap: () => _controller.reSendOTP(
                                      verificationId,
                                      resendToken!,
                                      phoneNumber),
                                  child: Text(
                                    'AppLanguage.RESEND[1]',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: AppFonts.INTER_REGULAR,
                                        color: _controller.timer.value == 0
                                            ? AppColors.themeColor
                                            : AppColors.BLACK,
                                        height: 1.2,
                                        decoration: TextDecoration.underline),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                if (_controller.timer.value != 0)
                                  Text(
                                    _controller.timer.value.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFonts.INTER_REGULAR,
                                      color: AppColors.BLACK,
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                              ],
                            ),
                          ),
                          Obx(() => _controller.isVerified.value
                              ? Container()
                              : CustomButton(
                                  buttonLabel: 'Verify',
                                  onTap: () =>
                                      _controller.verifyOTP(verificationId),
                                )),
                        ],
                      ),
                      const SizedBox(height: 86.16),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
