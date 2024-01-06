import 'package:bematched/screens/additional_info_screen/addition_info_button.dart';
import 'package:bematched/screens/additional_info_screen/additional_info_screen_controller.dart';
import 'package:bematched/widgets/custom_wheeler.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../utils/constants.dart';

class AdditionalInfoScreen extends StatelessWidget {
  AdditionalInfoScreen({super.key});

  final _controller = Get.put(AdditionalInfoScreenController());

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
          'Additional Information',
          style: TextStyle(
            fontSize: 22,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            children: [
              const SizedBox(height: 35),
              if ((_controller.userModel.connectionStatus ?? 0) == 0)
                Column(
                  children: [
                                                                                TextFormField(
                      initialValue: _controller.height.value,
                      onChanged: (val) => _controller.height.value = val,
                      decoration: const InputDecoration(
                          hintText: 'Height',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff8E8E8E),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.themeColor))),
                    ),
                    // Obx(
                    //   () => AdditionalInfoButton(
                    //     leading: 'Height',
                    //     suffix: _controller.height.value,
                    //     onTap: () {
                    //       Get.bottomSheet(
                    //         CustomWheeler(
                    //           initialIndex: _controller.heightList
                    //               .indexOf(_controller.height.value),
                    //           list: _controller.heightList,
                    //           onChangedChoice: (val) {
                    //             _controller.height.value =
                    //                 _controller.heightList.elementAt(val);
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                  ],
                ),
              Column(
                children: [
                                      TextFormField(
                      initialValue: _controller.educationLevel.value,
                      onChanged: (val) => _controller.educationLevel.value = val,
                      decoration: const InputDecoration(
                          hintText: 'Education Level',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff8E8E8E),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.themeColor))),
                    ),
                  // Obx(
                  //   () => AdditionalInfoButton(
                  //     leading: 'Education Level',
                  //     suffix: _controller.educationLevel.value,
                  //     onTap: () {
                  //       Get.bottomSheet(
                  //         CustomWheeler(
                  //           initialIndex: _controller.educationLevelList
                  //               .indexOf(_controller.educationLevel.value),
                  //           list: _controller.educationLevelList,
                  //           onChangedChoice: (val) {
                  //             _controller.educationLevel.value =
                  //                 _controller.educationLevelList.elementAt(val);
                  //           },
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
              if ((_controller.userModel.connectionStatus ?? 0) == 0 ||
                  (_controller.userModel.connectionStatus ?? 0) == 1)
                Column(
                  children: [
                    TextFormField(
                      initialValue: _controller.drinking.value,
                      onChanged: (val) => _controller.drinking.value = val,
                      decoration: const InputDecoration(
                          hintText: 'Drinking',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff8E8E8E),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.themeColor))),
                    ),
                    // Obx(
                    //   () => AdditionalInfoButton(
                    //     leading: 'Drinking',
                    //     suffix: _controller.drinking.value,
                    //     onTap: () {
                    //       Get.bottomSheet(
                    //         CustomWheeler(
                    //           initialIndex: _controller.drinkingList
                    //               .indexOf(_controller.drinking.value),
                    //           list: _controller.drinkingList,
                    //           onChangedChoice: (val) {
                    //             _controller.drinking.value =
                    //                 _controller.drinkingList.elementAt(val);
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                  ],
                ),
              if ((_controller.userModel.connectionStatus ?? 0) == 0 ||
                  (_controller.userModel.connectionStatus ?? 0) == 1)
                Column(
                  children: [
                                        TextFormField(
                      initialValue: _controller.smoking.value,
                      onChanged: (val) => _controller.smoking.value = val,
                      decoration: const InputDecoration(
                          hintText: 'Smoking',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff8E8E8E),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.themeColor))),
                    ),
                    // Obx(
                    //   () => AdditionalInfoButton(
                    //     leading: 'Smoking',
                    //     suffix: _controller.smoking.value,
                    //     onTap: () {
                    //       Get.bottomSheet(
                    //         CustomWheeler(
                    //           initialIndex: _controller.smokingList
                    //               .indexOf(_controller.smoking.value),
                    //           list: _controller.smokingList,
                    //           onChangedChoice: (val) {
                    //             _controller.smoking.value =
                    //                 _controller.smokingList.elementAt(val);
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                  ],
                ),
              if ((_controller.userModel.connectionStatus ?? 0) == 0)
                Column(
                  children: [
                                                            TextFormField(
                      initialValue: _controller.relationship.value,
                      onChanged: (val) => _controller.relationship.value = val,
                      decoration: const InputDecoration(
                          hintText: 'Relationship',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff8E8E8E),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.themeColor))),
                    ),
                    // Obx(
                    //   () => AdditionalInfoButton(
                    //     leading: 'Relationship',
                    //     suffix: _controller.relationship.value,
                    //     onTap: () {
                    //       Get.bottomSheet(
                    //         CustomWheeler(
                    //           initialIndex: _controller.relationshipList
                    //               .indexOf(_controller.relationship.value),
                    //           list: _controller.relationshipList,
                    //           onChangedChoice: (val) {
                    //             _controller.relationship.value =
                    //                 _controller.relationshipList.elementAt(val);
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 35),
                  ],
                ),
              if ((_controller.userModel.connectionStatus ?? 0) == 0 ||
                  (_controller.userModel.connectionStatus ?? 0) == 1)
                Column(
                  children: [
                    Obx(
                      () => AdditionalInfoButton(
                        leading: 'Zodiac sign',
                        suffix: _controller.zodiacSign.value,
                        onTap: () {
                          Get.bottomSheet(
                            CustomWheeler(
                              initialIndex: _controller.zodiacSignList
                                  .indexOf(_controller.zodiacSign.value),
                              list: _controller.zodiacSignList,
                              onChangedChoice: (val) {
                                _controller.zodiacSign.value =
                                    _controller.zodiacSignList.elementAt(val);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Column(
                children: [
                                                                              TextFormField(
                      initialValue: _controller.industry.value,
                      onChanged: (val) => _controller.industry.value = val,
                      decoration: const InputDecoration(
                          hintText: 'Industry',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff8E8E8E),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.themeColor))),
                    ),
                  // Obx(
                  //   () => AdditionalInfoButton(
                  //     leading: 'Industry',
                  //     suffix: _controller.industry.value,
                  //     onTap: () {
                  //       Get.bottomSheet(
                  //         CustomWheeler(
                  //           initialIndex: _controller.industryList
                  //               .indexOf(_controller.industry.value),
                  //           list: _controller.industryList,
                  //           onChangedChoice: (val) {
                  //             _controller.industry.value =
                  //                 _controller.industryList.elementAt(val);
                  //           },
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
              if ((_controller.userModel.connectionStatus ?? 0) == 2)
                Column(
                  children: [
                    Obx(
                      () => AdditionalInfoButton(
                        leading: 'Years of Experience',
                        suffix: _controller.yearOfExperience.value,
                        onTap: () {
                          Get.bottomSheet(
                            CustomWheeler(
                              initialIndex: _controller.yearOfExperienceList
                                  .indexOf(_controller.yearOfExperience.value),
                              list: _controller.yearOfExperienceList,
                              onChangedChoice: (val) {
                                _controller.yearOfExperience.value = _controller
                                    .yearOfExperienceList
                                    .elementAt(val);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              TextFormField(
                maxLines: 4,
                initialValue: _controller.work.value,
                onChanged: (val) => _controller.work.value = val,
                decoration: const InputDecoration(
                    hintText: 'Work',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: Color(0xff8E8E8E),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.themeColor))),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _controller.submit,
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
