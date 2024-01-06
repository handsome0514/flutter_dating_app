import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImageAssets.logo,
              width: Get.size.width * 0.45,
              color: AppColors.themeColor,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'No Record Found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.INTER_REGULAR,
              fontSize: 18,
            ),
          ),
        ]);
  }
}
