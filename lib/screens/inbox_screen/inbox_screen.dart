import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../widgets/inbox_widget.dart';
import '../../widgets/online_user_box.dart';
import 'inbox_screen_controller.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({super.key});

  final _controller = Get.put(InboxScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      body: GetBuilder<InboxScreenController>(
        builder: (controller) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 31),
/*              Padding(
                padding: const EdgeInsets.only(left: 19, right: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffEB4887),
                                Color(0xffFF2C6B),
                              ],
                            ),
                          ),
                          child: SvgPicture.asset(
                            SvgAssets.MESSAGE_ICON,
                            color: AppColors.whiteColor,
                            height: 16,
                            width: 19,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const SizedBox(width: 11),
                        const Text(
                          'Add New Message',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.INTER_SEMIBOLD,
                            color: AppColors.BLACK,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(SvgAssets.ARCHIVE_ICON),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xffEB4887),
                      Color(0xff8A52F3),
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(60)),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 23,top: 18,bottom: 19),
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: Color(0xffA3A3A3),
                    ),
                    hintText: 'Search Message',
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SvgPicture.asset(
                        SvgAssets.SEARCH_ICON,
                        height: 22,
                        width: 22,
                        color: const Color(0xff88868B),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 29),*/
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Activists',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                      color: AppColors.BLACK,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_controller.matchList.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 16),
                      ...List.generate(
                        _controller.matchList.length,
                        (index) => OnlineUserBox(
                          profileImage:
                              _controller.matchList[index].profileImage ?? '',
                          name: _controller.matchList[index].name ?? '',
                          isOnline: _controller.matchList[index].chatStatus ==
                              ChatStatus.online.index,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text('No Match'),
                  ),
                ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'All Messages',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: AppFonts.INTER_SEMIBOLD,
                      color: AppColors.BLACK,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              if (_controller.messagesList.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: List.generate(
                          _controller.messagesList.length,
                          (index) => InboxWidget(
                              threadModel: _controller.messagesList[index]),
                        ),
                      ),
                    ),
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text('No Messages'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
