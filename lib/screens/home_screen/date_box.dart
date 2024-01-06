import 'dart:developer';

import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/date_swipe_card.dart';
import 'package:bematched/widgets/no_record_found.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../config.dart';
import '../../network_service/network_services.dart';

class DateBox extends StatelessWidget {
  const DateBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 523,
      child: GetBuilder<HomeScreenController>(
        builder: (controller) {
          if ((controller.userModel.isDate ?? true) == false &&
              controller.userModel.connectionStatus == 0) {
            return Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.BLACK.withOpacity(.3))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'You disabled Date mode',
                      style: TextStyle(
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.BLACK,
                          fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Other people can\'t see your profile.Ready to return to dating?',
                      style: TextStyle(
                        fontFamily: AppFonts.INTER_SEMIBOLD,
                        color: AppColors.BLACK.withOpacity(.4),
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){
                      NetWorkServices.updateIsDate(true);
                      controller.loadUser();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.themeColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Enable Date Mode',
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
            );
          }
          if (controller.isLoading.value) {
            return const NativeProgress();
          }
          if (controller.isLoading.value == false && controller.list.isEmpty) {
            return const NoRecordFound();
          }
          log('Length>>>${controller.list.length}');
          return CardSwiper(
            controller: controller.swiperController,
            padding: const EdgeInsets.only(left: 8, right: 30),
            numberOfCardsDisplayed:
                controller.list.length >= 3 ? 3 : controller.list.length,
            cardsCount: controller.list.length,
            backCardOffset: const Offset(30, 0),
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) =>
                    DateSwipeCard(userModel: controller.list[index]),
            onSwipe: (index, i, direction) {
              log('index>>$index');
              log('Direction>> $direction');
              if (direction == CardSwiperDirection.right) {
                controller.likeUser(controller.list[index]);
              }
              if (direction == CardSwiperDirection.left) {
                controller.disLikeUser(controller.list[index]);
              }
              return true;
            },
            onEnd: () => controller.loadUser(),
            allowedSwipeDirection:
                AllowedSwipeDirection.only(left: true, right: true),
            isLoop: false,
          );
        },
      ),
    );
  }
}
