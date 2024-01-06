import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/network_service/network_services.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/screens/profile_screen/profile_screen.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class FollowBox extends StatelessWidget {
  const FollowBox({super.key, required this.userModel, required this.index});

  final UserModel userModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.only(top: 12, bottom: 11),
      width: 121,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.themeColor,
      ),
      child: Column(
        children: [
          AppCacheImage(
            imageUrl: userModel.profileImage ?? '',
            width: 89,
            height: 89,
            round: 44.5,
            onTap: () {
              Get.to(() => ProfileScreen(userModel: userModel));
            },
          ),
          const SizedBox(height: 7),
          GestureDetector(
            onTap: () async {
              var user = AdminBaseController.userData.value;
              await NetWorkServices.followUser(user, userModel);
              final ctrl = Get.find<HomeScreenController>();
              if (ctrl.followList.length > 1) {
                ctrl.followList.removeAt(index);
                ctrl.update(['follow']);
              } else {
                ctrl.loadFollower();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: AppColors.whiteColor),
              ),
              child: const Center(
                child: Text(
                  'Follow',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.INTER_REGULAR,
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
}
