import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/match_screen/match_screen_controller.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key, required this.likee});

  final UserModel likee;

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(MatchScreenController(likee));
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.MATCH_IMAGE,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned.fill(
            left: 49,
            bottom: 180,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: AppCacheImage(
                  imageUrl: _controller.likee.profileImage ?? '',
                  width: 140,
                  height: 140,
                  round: 70,
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 49,
            bottom: 280,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: AppCacheImage(
                  imageUrl: _controller.liker.profileImage ?? '',
                  width: 140,
                  height: 140,
                  round: 70,
                ),
              ),
            ),
          ),
          Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Column(
                      children: [
                        Text(
                          'Congrats!',
                          style: TextStyle(
                            fontSize: 45,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: Color(0xff33196B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'It’s a Match\nBelle & You both liked each other!',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Color(0xff645290),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _controller.goToChatScreen,
                      child: Column(
                        children: [
                          SvgPicture.asset(SvgAssets.MESSAGE_ICON),
                          const Text(
                            'Start Conversation',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: AppColors.themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 21),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: Get.back,
                      child: Image.asset(ImageAssets.KEEP_DATING),
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
