import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_svg/svg.dart';

import '../config.dart';
import '../utils/constants.dart';

class SwipeCard extends StatelessWidget {
  const SwipeCard({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 9),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            height: 363,
            child: Align(
              alignment: Alignment.centerRight,
              child: BlurryContainer(
                blur: 4,
                elevation: 0,
                color: AppColors.whiteColor.withOpacity(.22),
                padding: const EdgeInsets.all(8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(SvgAssets.LIKE_ICON),
                      const SizedBox(height: 10),
                      SvgPicture.asset(SvgAssets.COMMENT_ICON),
                      const SizedBox(height: 10),
                      SvgPicture.asset(SvgAssets.LIST_ICON),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 74,
                  width: 74,
                  decoration: BoxDecoration(
                    color: const Color(0xffC4C4C4).withOpacity(.23),
                    borderRadius: BorderRadius.circular(37),
                    border: Border.all(color: AppColors.whiteColor, width: 3),
                    image: const DecorationImage(
                      image: AssetImage(ImageAssets.homeBG),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Garima Bandari',
                      style: GoogleFonts.abhayaLibre(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    Text(
                      'Follow',
                      style: GoogleFonts.abhayaLibre(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
