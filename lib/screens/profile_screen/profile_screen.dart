import 'package:bematched/models/user_model.dart';
import 'package:bematched/network_service/network_services.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/gallery_screen/gallery_screen.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/screens/profile_screen/profile_screen_controller.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/profile_photos_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config.dart';
import '../../models/thread_model.dart';
import '../../utils/extension.dart';
import '../../widgets/bio_button.dart';
import '../../widgets/custom_dailogs.dart';
import '../chat_screen/chat_screen.dart';
import '../navbar_screen/navbar_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.userModel});

  final UserModel userModel;

  final _homeController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(ProfileScreenController(userModel));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: GetBuilder<ProfileScreenController>(
          builder: (controller) => Column(
            children: [
              Stack(
                children: [
                  AppCacheImage(
                    imageUrl: userModel.profileImage ?? '',
                    width: double.infinity,
                    height: Get.height / 2,
                  ),
                  Positioned(
                    top: 45,
                    right: 20,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        CustomDailogs.userDetail(
                          Get.context!,
                          userModel: userModel,
                        );
                      },
                      child: SvgPicture.asset(
                        SvgAssets.LIST_ICON,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 80,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 35,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (!(AdminBaseController.userData.value
                              .isMatched(userModel.uid!)))
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: PhysicalModel(
                                color: AppColors.themeColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(37),
                                elevation: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      _homeController.swiperController
                                          .swipeLeft();
                                    });
                                  },
                                  child: Container(
                                    height: 78,
                                    width: 78,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(37),
                                      color: AppColors.WHITE,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          SvgAssets.CLOSE_ICON),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (!(AdminBaseController.userData.value
                              .isMatched(userModel.uid!)))
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: PhysicalModel(
                                color: AppColors.themeColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(37),
                                elevation: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      _homeController.swiperController
                                          .swipeRight();
                                    });
                                  },
                                  child: Container(
                                    height: 99,
                                    width: 99,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(47.5),
                                      color: AppColors.themeColor,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        SvgAssets.SELECTED_HEART_ICON,
                                        height: 36,
                                        width: 42,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (!(AdminBaseController.userData.value.following
                                  ?.contains(userModel.uid) ??
                              false))
                            PhysicalModel(
                              color: AppColors.themeColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(37),
                              elevation: 6,
                              child: GestureDetector(
                                onTap: () {
                                  var myProfile =
                                      AdminBaseController.userData.value;
                                  NetWorkServices.followUser(
                                      myProfile, userModel);
                                  Get.back();
                                },
                                child: Container(
                                  height: 78,
                                  width: 78,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(37),
                                    color: AppColors.WHITE,
                                  ),
                                  child: Center(
                                    child:
                                        SvgPicture.asset(SvgAssets.STAR_ICON),
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox(
                              height: 78,
                              width: 78,
                            )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 15,
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 19, bottom: 19, left: 21.5, right: 22.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xffE8E6EA),
                          ),
                          color: AppColors.WHITE.withOpacity(.2),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.whiteColor,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.WHITE,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userModel.name}, ${userModel.age}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.BLACK,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text(
                                  userModel.work ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.INTER_REGULAR,
                                    color: AppColors.BLACK.withOpacity(.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if ((AdminBaseController.userData.value
                            .isMatched(userModel.uid!)))
                          GestureDetector(
                            onTap: () async {
                              final _baseController =
                                  BaseController(Get.context, () {});
                              try {
                                var thread;

                                var myProfile =
                                    AdminBaseController.userData.value;
                                _baseController.showProgress();
                                var threadId = createThreadId(
                                    userModel.uid!, myProfile.uid!);
                                var doc = await FirebaseFirestore.instance
                                    .collection(ThreadModel.TABLE_NAME)
                                    .doc(threadId)
                                    .get();
                                if (doc.data() != null) {
                                  thread = ThreadModel.fromJson(doc.data()!);
                                  var userModel =
                                      await NetWorkServices.getUserDetailById(
                                          thread.participantUserList![0] ==
                                                  AdminBaseController
                                                      .userData.value.uid
                                              ? thread.participantUserList![1]
                                              : thread.participantUserList![0]);
                                  if (userModel == null) return;
                                  thread.userDetail = userModel;
                                }

                                Get.back();
                                final ctrl = Get.find<NavBarScreenController>();
                                ctrl.selectedIndex.value = 2;
                                ctrl.update();
                                _baseController.hideProgress();
                                Get.to(
                                  () => ChatScreen(threadModel: thread),
                                  transition: Transition.rightToLeft,
                                );
                              } catch (e) {
                                _baseController.hideProgress();
                                print(e);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 15.5,
                                  bottom: 15.5,
                                  left: 16.39,
                                  right: 16.39),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffE8E6EA)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                SvgAssets.SEND_ICON,
                                color: AppColors.themeColor,
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.BLACK,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                userModel.location ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  color: AppColors.BLACK.withOpacity(.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 13, bottom: 13, left: 15.5, right: 15.5),
                          decoration: BoxDecoration(
                            color: AppColors.themeColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  color: AppColors.themeColor, size: 16),
                              const SizedBox(width: 8.72),
                              Text(
                                '${userModel.distance} Km',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.INTER_BOLD,
                                  color: AppColors.themeColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 28),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_BOLD,
                            color: AppColors.BLACK,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.25),
                          child: ExpandableText(
                            userModel.bios ?? '',
                            expandText: 'show more',
                            collapseText: 'show less',
                            maxLines: 3,
                            linkColor: AppColors.themeColor,
                            linkStyle: const TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.themeColor,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.INTER_REGULAR,
                              color: AppColors.BLACK.withOpacity(.7),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Interests',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_BOLD,
                            color: AppColors.BLACK,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 12,
                          runSpacing: 15,
                          direction: Axis.horizontal,
                          children: List.generate(
                            userModel.interest?.length ?? 0,
                            (i) => Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.themeColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    interests[userModel.interest?[i]]["icon"],
                                    color: AppColors.themeColor,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    interests[userModel.interest?[i]]["text"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.themeColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      SizedBox(
                                        width: 160,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (_controller.userModel.work
                                                    ?.isNotEmpty ??
                                                false)
                                              Expanded(
                                                child: Text(
                                                  _controller.userModel.work ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFonts.INTER_MEDIUM,
                                                    color: AppColors.themeColor,
                                                  ),
                                                ),
                                              )
                                            else
                                              const Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: AppFonts
                                                            .INTER_MEDIUM,
                                                        color: AppColors
                                                            .themeColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            const SizedBox(width: 13),
                                            Transform.flip(
                                              flipX: true,
                                              child: const Icon(
                                                Icons.arrow_back_ios_new,
                                                color: AppColors.themeColor,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 17),
                              ],
                            ),
                            if ((_controller.userModel.connectionStatus ?? 0) ==
                                    0 &&
                                (_controller.userModel.height?.isNotEmpty ??
                                    false))
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Height',
                                      suffix:
                                          _controller.userModel.height ?? ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if (_controller
                                    .userModel.educationLevel?.isNotEmpty ??
                                false)
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Education level',
                                      suffix: _controller
                                              .userModel.educationLevel ??
                                          ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if ((_controller.userModel.connectionStatus ?? 0) ==
                                    0 ||
                                (_controller.userModel.connectionStatus ?? 0) ==
                                        1 &&
                                    (_controller
                                            .userModel.drinking?.isNotEmpty ??
                                        false))
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Drinking',
                                      suffix:
                                          _controller.userModel.drinking ?? ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if ((_controller.userModel.connectionStatus ?? 0) ==
                                    0 ||
                                (_controller.userModel.connectionStatus ?? 0) ==
                                        1 &&
                                    (_controller
                                            .userModel.smoking?.isNotEmpty ??
                                        false))
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Smoking',
                                      suffix:
                                          _controller.userModel.smoking ?? ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if ((_controller.userModel.connectionStatus ?? 0) ==
                                    0 &&
                                (_controller
                                        .userModel.relationship?.isNotEmpty ??
                                    false))
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Relationship',
                                      suffix:
                                          _controller.userModel.relationship ??
                                              ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if (_controller.userModel.industry?.isNotEmpty ??
                                false)
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Industry',
                                      suffix:
                                          _controller.userModel.industry ?? ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if ((_controller.userModel.connectionStatus ?? 0) ==
                                    2 &&
                                (_controller.userModel.yearsOfExperience
                                        ?.isNotEmpty ??
                                    false))
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Years of experience',
                                      suffix: _controller
                                              .userModel.yearsOfExperience ??
                                          ''),
                                  const SizedBox(height: 17),
                                ],
                              ),
                            if ((_controller.userModel.connectionStatus ?? 0) ==
                                    0 ||
                                (_controller.userModel.connectionStatus ?? 0) ==
                                        1 &&
                                    (_controller
                                            .userModel.zodiacSign?.isNotEmpty ??
                                        false))
                              Column(
                                children: [
                                  BioButton(
                                      leading: 'Zodiac sign',
                                      suffix:
                                          _controller.userModel.zodiacSign ??
                                              ''),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 26),
                        ProfilePhotosWidget(
                          photosPattern: const [230.13, 204.13, 230.13, 204.13],
                          images: userModel.images ?? [],
                          seeAllClicked: () => Get.to(
                            () => GalleryScreen(
                              userModel: userModel,
                              isMyProfile: false,
                            ),
                            transition: Transition.rightToLeft,
                          ),
                        ),
                        const SizedBox(height: 41),
                      ],
                    ),
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
