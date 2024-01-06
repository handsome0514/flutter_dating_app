import 'package:bematched/utils/app_cache_image.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OnlineUserBox extends StatelessWidget {
  const OnlineUserBox(
      {super.key, required this.profileImage, required this.name, required this.isOnline});

  final String profileImage;
  final String name;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          Stack(
            children: [
              AppCacheImage(
                imageUrl: profileImage,
                width: 63.74,
                height: 63.74,
                round: 32,
              ),
              if(isOnline)
              Positioned(
                bottom: 4,
                right: 2,
                child: Container(
                  height: 13,
                  width: 13,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 9,
                      width: 9,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
      /*    const SizedBox(height: 10.62),
          Text(
            name,
            style: const TextStyle(
              fontSize: 11.69,
              fontFamily: AppFonts.INTER_MEDIUM,
              color: AppColors.BLACK,
            ),
          ),*/
        ],
      ),
    );
  }
}
