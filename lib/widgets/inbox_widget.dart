import 'package:bematched/models/thread_model.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/profile_screen/profile_screen.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/chat_screen/chat_screen.dart';
import '../utils/constants.dart';

class InboxWidget extends StatelessWidget {
  const InboxWidget({super.key, required this.threadModel});

  final ThreadModel threadModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.to(
          () => ChatScreen(
            threadModel: threadModel,
          ),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding:
            const EdgeInsets.only(top: 20, bottom: 11, left: 17, right: 13),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            AppCacheImage(
              imageUrl: threadModel.userDetail?.profileImage ?? '',
              width: 60,
              height: 60,
              round: 10,
              onTap: () {
                Get.to(
                  () => ProfileScreen(userModel: threadModel.userDetail!),
                  transition: Transition.rightToLeft,
                );
              },
            ),
            const SizedBox(width: 21),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            threadModel.userDetail?.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.INTER_SEMIBOLD,
                              color: Color(0xff33196B),
                            ),
                          ),
                          if (threadModel.userDetail?.chatStatus ==
                              ChatStatus.online.index)
                            Row(
                              children: [
                                const SizedBox(width: 6),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff12D13C),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Text(
                        threadModel.lastMessageTime?.toDate().hh_mm_a ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: Color(0xff4635E2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          threadModel.lastMessage ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: Color(0xff745594),
                          ),
                        ),
                      ),
                      if ((threadModel.messageCount ?? 0) != 0 &&
                          threadModel.senderId !=
                              AdminBaseController.userData.value.uid)
                        Container(
                          margin: const EdgeInsets.only(top: 9),
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.themeColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              (threadModel.messageCount ?? 0).toString(),
                              style: const TextStyle(
                                fontSize: 13.81,
                                fontFamily: AppFonts.INTER_REGULAR,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    connectionList[
                        threadModel.userDetail?.connectionStatus ?? 0]['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: ((threadModel.userDetail?.connectionStatus ?? 0) ==
                              0)
                          ? Colors.yellow
                          : ((threadModel.userDetail?.connectionStatus ?? 0) ==
                                  1)
                              ? Colors.blue
                              : Colors.orange,
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
