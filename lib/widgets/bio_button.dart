import 'package:flutter/material.dart';

import '../config.dart';
import '../screens/additional_info_screen/additional_info_screen.dart';
import '../utils/constants.dart';

class BioButton extends StatelessWidget {
  const BioButton({super.key, required this.leading, required this.suffix, this.isMyProfile =false});

  final String leading;
  final String suffix;
  final bool isMyProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     behavior: HitTestBehavior.opaque,
      onTap: (){
       if(isMyProfile == false)return;
      //  Get.to(
      //        () => AdditionalInfoScreen(),
      //    transition: Transition.rightToLeft,
      //  );

      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        // decoration: BoxDecoration(
        //   border: Border(
        //       bottom:
        //           BorderSide(color: const Color(0xffE4E4E4).withOpacity(.55))),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leading,
              style: const TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.INTER_MEDIUM,
                color: AppColors.BLACK,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  suffix,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: AppColors.BLACK,
                    // color: AppColors.themeColor,

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
    );
  }
}
