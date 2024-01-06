import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config.dart';
import 'subscription_screen_controller.dart';

class SubScriptionScreen extends StatelessWidget {
  SubScriptionScreen({super.key});

  final _controller = Get.put(SubscriptionScreenController());

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'For Best Access',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: AppFonts.INTER_SEMIBOLD,
                    color: AppColors.BLACK,
                  ),
                ),
              ),
              const SizedBox(height: 11),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      'Subscribe a plan',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.INTER_SEMIBOLD,
                        color: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(SvgAssets.SELECTED_HEART_ICON),
                  ],
                ),
              ),
              const SizedBox(height: 29),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Top feautures you will get',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: AppFonts.INTER_SEMIBOLD,
                    color: AppColors.themeColor,
                  ),
                ),
              ),
              const SizedBox(height: 11),
              Row(
                children: [
                  Transform.flip(
                    flipX: true,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: AppColors.themeColor,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Text(
                    'Find out who’s following you ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.BLACK.withOpacity(.61),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Transform.flip(
                    flipX: true,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: AppColors.themeColor,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Text(
                    'Contact popular and new users',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.BLACK.withOpacity(.61),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Transform.flip(
                    flipX: true,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: AppColors.themeColor,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Text(
                    'Browse profile invisibly & ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.BLACK.withOpacity(.61),
                    ),
                  ),
                  const Text(
                    'Many more...',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                      color: AppColors.BLACK,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Select your Plan',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: AppFonts.INTER_SEMIBOLD,
                    color: AppColors.themeColor,
                  ),
                ),
              ),
              ...List.generate(
                _controller.subscriptionList.length,
                (index) => Obx(
                  () => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _controller.selectedIndex.value = index,
                    child: Container(
                      margin: const EdgeInsets.only(top: 24),
                      padding: const EdgeInsets.only(left: 29, right: 28),
                      height: 88,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(60),
                          border: _controller.selectedIndex.value == index
                              ? Border.all(color: AppColors.themeColor, width: 2)
                              : null),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              _controller.subscriptionList[index]['icon']),
                          const SizedBox(width: 17),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _controller.subscriptionList[index]['title'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppFonts.INTER_SEMIBOLD,
                                  color: AppColors.themeColor,
                                ),
                              ),
                              Text(
                                _controller.subscriptionList[index]['duration'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: AppFonts.INTER_MEDIUM,
                                  color: AppColors.BLACK.withOpacity(.44),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '\$${_controller.subscriptionList[index]['price']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: AppFonts.INTER_MEDIUM,
                              color: AppColors.themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 46),
              Container(
                padding: const EdgeInsets.only(top: 20,bottom: 20,left: 58,right: 58),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: AppColors.themeColor),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFonts.INTER_SEMIBOLD,
                    color: AppColors.whiteColor,
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
