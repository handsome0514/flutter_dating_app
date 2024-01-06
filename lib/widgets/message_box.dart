import 'package:bematched/models/chat_model.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/admin_base_controller.dart';
import '../utils/constants.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {super.key,
      this.userName = '', required this.chatModel});

  final ChatModel chatModel;

  final String userName;


  @override
  Widget build(BuildContext context) {
    final isYou = chatModel.senderId ==
        AdminBaseController.userData.value.uid;
    return Align(
      alignment: isYou ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: Get.width * 0.70, minWidth: Get.width * .0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          //isYou ? AppColors.LOCATION_COLOR : AppColors.SILICON_VELLEY,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(35),
            bottomRight: const Radius.circular(35),
            topRight: isYou ? Radius.zero : const Radius.circular(35),
            topLeft: isYou ? const Radius.circular(35) : Radius.zero,
          ),
        ),
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
        padding:
            const EdgeInsets.only(top: 20, bottom: 22, left: 34, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isYou ? 'You' : userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.INTER_BOLD,
                    color: isYou ? Color(0xff4635E2) : AppColors.themeColor,
                  ),
                ),
                Text(
                  chatModel.messageTime!.toDate().hh_mm_a,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: AppColors.BLACK.withOpacity(.55),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (chatModel.fileUrl?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: AppCacheImage(
                    imageUrl: chatModel.fileUrl ?? '',
                    width: Get.width / 2,
                    height: null),
              ),
            Text(
              chatModel.message??'',
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.INTER_MEDIUM,
                color: AppColors.BLACK.withOpacity(.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
