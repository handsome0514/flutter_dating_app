import 'package:bematched/config.dart';
import 'package:bematched/screens/additional_info_screen/additional_info_screen.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/edit_profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:bematched/screens/personal_profile_screen/personal_profile_screen_controller.dart';
import 'package:bematched/screens/setting_screens/settings_screen/setting_screen.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/bio_button.dart';
import 'package:bematched/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({super.key});

  final _controller = Get.put(PersonalProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.to(() => SettingScreen(), transition: Transition.rightToLeft);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.settings,
                color: AppColors.themeColor,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<PersonalProfileScreenController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: AppCacheImage(
                      imageUrl: _controller.userModel.profileImage ?? '',
                      width: null,
                      height: 213,
                      round: 0,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 213,
                      child: Column(
                        children: [
                          const Divider(color: Color(0xffDFD2F3)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite_border_outlined,
                                  color: AppColors.themeColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _controller.matchCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: Color(0xff645290),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Color(0xffDFD2F3)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(SvgAssets.PERSONAL_LIKE_ICON),
                                const SizedBox(width: 8),
                                Text(
                                  _controller.followingCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: Color(0xff645290),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Color(0xffDFD2F3)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    SvgAssets.PERSONAL_COMMENT_ICON),
                                const SizedBox(width: 8),
                                Text(
                                  _controller.threadCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: Color(0xff645290),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Color(0xffDFD2F3)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              if (_controller.userModel.percentage != 100)
                Container(
                  margin: const EdgeInsets.only(left: 19, right: 19),
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 13, left: 15, right: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: AppColors.whiteColor),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 58,
                        width: 58,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              showLabels: false,
                              showTicks: false,
                              startAngle: 270,
                              endAngle: 270,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 1,
                                color: Colors.transparent,
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                const RangePointer(
                                  value: 100,
                                  cornerStyle: CornerStyle.bothFlat,
                                  width: 0.2,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: Color(0xffFEC3E4),
                                ),
                                RangePointer(
                                  value: _controller.userModel.percentage
                                      .toDouble(),
                                  cornerStyle: CornerStyle.bothCurve,
                                  width: 0.2,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: AppColors.themeColor,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  positionFactor: 0.4,
                                  angle: 90,
                                  widget: Center(
                                    child: Text(
                                      '${_controller.userModel.percentage}%',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppFonts.INTER_SEMIBOLD,
                                        color: AppColors.themeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 11),
                      const Text(
                        'Complete your profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: Color(0xff252526),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.to(() => AdditionalInfoScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 6, left: 13, right: 13),
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_controller.userModel.name ?? ' '}, ${_controller.userModel.age}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontFamily: AppFonts.INTER_SEMIBOLD,
                        color: AppColors.BLACK,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.to(
                          () => EditProfileScreen(),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.themeColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  children: [
                    if (_controller.userModel.phoneNumber != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: AppColors.BLACK,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _controller.userModel.phoneNumber ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: AppColors.BLACK,
                            ),
                          ),
                        ],
                      ),
                    if (_controller.userModel.phoneNumber != null &&
                        _controller.userModel.email != null)
                      const SizedBox(width: 28),
                    if (_controller.userModel.email != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: AppColors.BLACK,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _controller.userModel.email ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: AppColors.BLACK,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 55),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.BLACK,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _controller.userModel.bios ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_REGULAR,
                              color: AppColors.BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 19),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 55),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Location',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.BLACK,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _controller.userModel.location ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 19),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  children: List.generate(
                    _controller.stringList.length,
                    (index) => Obx(
                      () => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _controller.selectedIndex.value = index,
                        child: Container(
                          margin: const EdgeInsets.only(right: 36),
                          padding: const EdgeInsets.only(bottom: 9),
                          decoration: BoxDecoration(
                            border: _controller.selectedIndex.value == index
                                ? const Border(
                                    bottom: BorderSide(
                                        color: AppColors.themeColor, width: 2))
                                : null,
                          ),
                          child: Text(
                            _controller.stringList[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: _controller.selectedIndex.value == index
                                  ? AppColors.themeColor
                                  : AppColors.BLACK.withOpacity(.23),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Obx(() {
                if (_controller.selectedIndex.value == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: const Color(0xffE4E4E4)
                                            .withOpacity(.55))),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Work',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: AppFonts.INTER_MEDIUM,
                                      color: AppColors.BLACK,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      if (_controller
                                              .userModel.work?.isNotEmpty ??
                                          false)
                                        Text(
                                          _controller.userModel.work ??
                                              '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily:
                                                AppFonts.INTER_MEDIUM,
                                            color: AppColors.BLACK,
                                          ),
                                        )
                                      else
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily:
                                                      AppFonts.INTER_MEDIUM,
                                                  color:
                                                      AppColors.BLACK,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      // const SizedBox(width: 13),
                                      // Transform.flip(
                                      //   flipX: true,
                                      //   child: const Icon(
                                      //     Icons.arrow_back_ios_new,
                                      //     color: AppColors.themeColor,
                                      //     size: 18,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 17),
                          ],
                        ),
                        if ((_controller.userModel.connectionStatus ?? 0) == 0)
                          Column(
                            children: [
                              BioButton(
                                leading: 'Height',
                                suffix: _controller.userModel.height ?? '',
                                isMyProfile: true,
                              ),
                              const SizedBox(height: 17),
                            ],
                          ),
                        Column(
                          children: [
                            BioButton(
                              leading: 'Education level',
                              suffix:
                                  _controller.userModel.educationLevel ?? '',
                              isMyProfile: true,
                            ),
                            const SizedBox(height: 17),
                          ],
                        ),
                        if ((_controller.userModel.connectionStatus ?? 0) ==
                                0 ||
                            (_controller.userModel.connectionStatus ?? 0) == 1)
                          Column(
                            children: [
                              BioButton(
                                leading: 'Drinking',
                                suffix: _controller.userModel.drinking ?? '',
                                isMyProfile: true,
                              ),
                              const SizedBox(height: 17),
                            ],
                          ),
                        if ((_controller.userModel.connectionStatus ?? 0) ==
                                0 ||
                            (_controller.userModel.connectionStatus ?? 0) == 1)
                          Column(
                            children: [
                              BioButton(
                                leading: 'Smoking',
                                suffix: _controller.userModel.smoking ?? '',
                                isMyProfile: true,
                              ),
                              const SizedBox(height: 17),
                            ],
                          ),
                        if ((_controller.userModel.connectionStatus ?? 0) == 0)
                          Column(
                            children: [
                              BioButton(
                                leading: 'Relationship',
                                suffix:
                                    _controller.userModel.relationship ?? '',
                                isMyProfile: true,
                              ),
                              const SizedBox(height: 17),
                            ],
                          ),
                        Column(
                          children: [
                            BioButton(
                              leading: 'Industry',
                              suffix: _controller.userModel.industry ?? '',
                              isMyProfile: true,
                            ),
                            const SizedBox(height: 17),
                          ],
                        ),
                        if ((_controller.userModel.connectionStatus ?? 0) == 2)
                          Column(
                            children: [
                              BioButton(
                                leading: 'Years of experience',
                                suffix:
                                    _controller.userModel.yearsOfExperience ??
                                        '',
                                isMyProfile: true,
                              ),
                              const SizedBox(height: 17),
                            ],
                          ),
                        if ((_controller.userModel.connectionStatus ?? 0) ==
                                0 ||
                            (_controller.userModel.connectionStatus ?? 0) == 1)
                          Column(
                            children: [
                              BioButton(
                                leading: 'Zodiac sign',
                                suffix: _controller.userModel.zodiacSign ?? '',
                                isMyProfile: true,
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 18),
                      ...List.generate(
                        _controller.userModel.images?.length ?? 0,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: AppCacheImage(
                              imageUrl: _controller.userModel.images![index],
                              width: 90,
                              height: 90,
                              round: 8),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 27),
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Interests',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                      color: AppColors.BLACK,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    ...List.generate(
                        _controller.userModel.interest?.length ?? 0,
                        (index) => Row(
                              children: [
                                Icon(
                                    interests[_controller
                                        .userModel.interest![index]]['icon'],
                                    size: 19,
                                    color: AppColors.themeColor),
                                const SizedBox(width: 6.58),
                                Text(
                                  interests[_controller
                                      .userModel.interest![index]]['text'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: AppColors.themeColor,
                                  ),
                                ),
                                const SizedBox(width: 24),
                              ],
                            ))
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
