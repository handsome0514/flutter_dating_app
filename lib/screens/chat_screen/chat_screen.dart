import 'dart:io';

import 'package:bematched/models/chat_model.dart';
import 'package:bematched/models/thread_model.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/extension.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/base_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/message_box.dart';
import '../admin_base_controller.dart';
import 'chat_screen_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.threadModel});

  final ThreadModel threadModel;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _controller = Get.put(ChatScreenController(threadModel));
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      body: Column(
        children: [
          GetBuilder<ChatScreenController>(
            id: 'header',
            builder: (controller) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffEB4887),
                  const Color(0xff8354FF).withOpacity(.62),
                ], begin: Alignment.topRight, end: Alignment.bottomRight),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 14, bottom: 14, left: 18, right: 18),
                child: SafeArea(
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: Get.back,
                        child: const Icon(Icons.arrow_back_ios,
                            color: AppColors.whiteColor),
                      ),
                      const SizedBox(width: 5),
                      AppCacheImage(
                        imageUrl:
                            _controller.threadModel?.userDetail?.profileImage ??
                                '',
                        width: 44,
                        height: 44,
                        round: 22,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _controller.threadModel?.userDetail?.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: AppFonts.INTER_SEMIBOLD,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),if (_controller.threadModel?.userDetail?.chatStatus ==
                                  ChatStatus.online.index)
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                (_controller.threadModel?.userDetail?.chatStatus ==
                                    ChatStatus.online.index)
                                    ? 'Online'
                                    : (_controller.threadModel?.userDetail
                                    ?.chatStatus ==
                                    ChatStatus.typing.index)
                                    ? 'Typing...'
                                    : _controller
                                    .threadModel!.userDetail!.lastActive!
                                    .toDate()
                                    .lastActive,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),


                      const Spacer(),
                      /*        SvgPicture.asset(SvgAssets.AUDIO_CALL_ICON),
                      const SizedBox(width: 20),*/
                      SvgPicture.asset(
                        SvgAssets.VIDEO_CALL_ICON,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: _controller.chatList,
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset(SvgAssets.CHAT_LIST_ICON,
                            color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: GetBuilder<ChatScreenController>(
                  id: 'chat',
                  builder: (controller) {
                    if (controller.isLoading.value == false &&
                        controller.messageList.isEmpty) {
                      return const Center(
                          child: Text('Enter your first message'));
                    }
                    if (_controller.isLoading.value == true &&
                        _controller.messageList.isEmpty) {
                      return const NativeProgress();
                    }
                    return Obx(
                      () => ListView.builder(
                        controller: _controller.scrollController,
                        padding: const EdgeInsets.only(top: 15),
                        shrinkWrap: true,
                        itemCount: controller.messageList.length,
                        reverse: true,
                        itemBuilder: (_, index) => Column(
                          children: [
                            Obx(() => controller.isLoading.value && 0 == index
                                ? const Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : Container()),
                            MessageBox(
                              userName:
                                  _controller.threadModel?.userDetail?.name ??
                                      '',
                              chatModel: _controller.messageList[index],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          GetBuilder<ChatScreenController>(
              id: 'bottom',
              builder: (controller) {
                if (controller.threadModel?.isBlocked == false) {
                  return Column(
                    children: [
                      if (_controller.pathList.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 4),
                          child: Row(
                            children: List.generate(
                              _controller.pathList.length,
                              (index) => Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(
                                        File(_controller.pathList[index])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        _controller.pathList.removeAt(index);
                                        _controller.update(['bottom']);
                                      },
                                      child: const Icon(Icons.close, size: 18)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 26, left: 22, right: 22),
                        decoration: const BoxDecoration(color: AppColors.whiteColor),
                        child: Row(
                          children: [

                            Expanded(
                              child: TextFormField(
                                focusNode: _controller.focusNode,
                                controller: _controller.chatController,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.INTER_MEDIUM,
                                  color: AppColors.themeColor,
                                ),
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  hintText: 'Type a message...',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: AppFonts.INTER_MEDIUM,
                                    color: AppColors.themeColor,
                                  ),
                                  constraints: BoxConstraints(),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _controller.filePick,
                              child: SvgPicture.asset(SvgAssets.ATTACH_ICON),
                            ),
                            const SizedBox(width: 24),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: _controller.sendMessage,
                              child: SvgPicture.asset(SvgAssets.SEND_ICON),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              })
        ],
      ),
    );
  }
}
