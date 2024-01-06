import 'dart:developer';

import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'phone_screen_controller.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({super.key});

  final PhoneScreenController _controller = Get.put(PhoneScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
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
                      ),
                      const SizedBox(height: 62.87),
                      const Text(
                        'What is Your Number',
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
                        'We Will send you OTP',
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
                        children: [
                          Container(
                            height: 52,
                            //  width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: AppColors.themeColor, width: 1)),
                            child: CountryCodePicker(
                              padding: EdgeInsets.zero,
                              flagWidth: 24,
                              showDropDownButton: true,
                              hideMainText: true,
                              onInit: (country) {
                                if (country!.dialCode == null) return;
                                _controller.dailCode = country.dialCode!;
                                log(country.dialCode.toString());
                              },
                              onChanged: (country) {
                                if (country.dialCode == null) return;
                                _controller.dailCode = country.dialCode!;
                                log(country.dialCode.toString());
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'US',
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                // maxLength: 10,
                                onChanged: (val) {
                                  _controller.phoneNumber = val;
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'Enter Number',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppFonts.INTER_REGULAR,
                                    color:
                                        AppColors.themeColor.withOpacity(.75),
                                  ),
                                  // contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: AppColors.themeColor, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: AppColors.themeColor, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                        color: AppColors.themeColor, width: 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(height: 86.6),
                      CustomButton(
                        buttonLabel: 'Next',
                        onTap: _controller.goToOTPScreen,
                      ),
                      const SizedBox(height: 40.6),
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
