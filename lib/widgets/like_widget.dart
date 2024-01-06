import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/profile_screen/profile_screen.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class LikeWidget extends StatelessWidget {
  const LikeWidget({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.to(() => ProfileScreen(userModel: userModel));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppCacheImage(
              imageUrl: userModel.profileImage ?? '',
              width: null,
              height: null),
          if (userModel.chatStatus == ChatStatus.online.index)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffBFFF6F),
                ),
              ),
            ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 7, bottom: 8, left: 11, right: 11),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    const Color(0xff120130),
                    const Color(0xff0E0124).withOpacity(.8),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '${userModel.name}, ${userModel.age}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${userModel.distance} km away',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: AppColors.WHITE,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(SvgAssets.CAMERA_ICON),
                            const SizedBox(width: 5),
                            Text(
                              userModel.images?.length.toString() ??
                                  0.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: AppFonts.INTER_MEDIUM,
                                color: AppColors.WHITE,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
