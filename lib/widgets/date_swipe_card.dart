import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:flutter_svg/svg.dart';

import '../config.dart';
import '../screens/profile_screen/profile_screen.dart';
import '../utils/constants.dart';

class DateSwipeCard extends StatelessWidget {
  DateSwipeCard({super.key, required this.userModel});

  final UserModel userModel;

  final _controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileScreen(userModel: userModel),
            transition: Transition.rightToLeft);
      },
      child: Container(
        //    padding: const EdgeInsets.only(top: 11, left: 14, right: 14, bottom: 15),
        height: 523,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: NetworkImage(userModel.profileImage ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 11, left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.2),
                    Colors.black.withOpacity(.01)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: const Color(0xff2AAC7A))),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        Text(
                          (userModel.connectionStatus ?? 0) == 1
                              ? 'BFF'
                              : (userModel.connectionStatus ?? 0) == 2
                                  ? 'BIZZ'
                                  : 'Date',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => _controller.swiperController.swipeRight(),
                      child: SvgPicture.asset(SvgAssets.DATE_LIKE_ICON))
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(bottom: 15, left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(.8),
                    Colors.white.withOpacity(.1)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${userModel.name}, ${userModel.age}',
                    style: GoogleFonts.abhayaLibre(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          color: AppColors.BLACK,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    userModel.location ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.BLACK,
                      fontFamily: AppFonts.INTER_MEDIUM,
                    ),
                  ),
                  Text(
                    'Waiting for someone who would be my best partner',
                    style: GoogleFonts.abhayaLibre(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
