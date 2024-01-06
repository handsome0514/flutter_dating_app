import 'package:bematched/screens/home_screen/date_box.dart';
import 'package:bematched/screens/home_screen/follow_box.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/screens/navbar_screen/navbar_screen_controller.dart';
import 'package:bematched/screens/status_screen/status_screen.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/storyview/widgets/story_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config.dart';
import '../../widgets/filter_bottomsheet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeScreenController());

  final _navController = Get.find<NavBarScreenController>();

  // List tabWidget = [BFFBox(), DateBox(), BFFBox()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              if (kDebugMode) {
                print('object');
              }

              if (_navController.scaffoldKey.currentState?.isDrawerOpen ?? false) {
                _navController.scaffoldKey.currentState!.closeDrawer();
                //close drawer, if drawer is open
              } else {
                _navController.scaffoldKey.currentState!.openDrawer();
                //open drawer, if drawer is closed
              }
            },
            child: const Icon(
              Icons.list,
              color: AppColors.themeColor,
              size: 30,
            )),
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.bottomSheet(
                  FilterBottomSheet(),
                  isScrollControlled: true,
                  persistent: false,
                  enableDrag: true,
                );
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(
                      top: 14, bottom: 14, left: 14, right: 13),
                  child: SvgPicture.asset(SvgAssets.FILTER_ICON)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 42),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _controller.createStory,
                      child: Container(
                        height: 74,
                        width: 74,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xffC4C4C4).withOpacity(.23),
                          borderRadius: BorderRadius.circular(37),
                          border:
                              Border.all(color: AppColors.themeColor, width: 2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: AppColors.themeColor,
                            size: 29,
                            weight: 2000,
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<HomeScreenController>(
                        id: 'story',
                        builder: (controller) {
                          if (_controller.storyList.isEmpty &&
                              _controller.isStoryLoading == true) {
                            return const SizedBox(
                              height: 100,
                              child: NativeProgress(),
                            );
                          }
                          if (_controller.storyList.isNotEmpty &&
                              _controller.isStoryLoading == false) {
                            return Row(
                              children: List.generate(
                                _controller.storyList.length,
                                (index) => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Get.to(
                                      () => StatusScreen(
                                        index: 0,
                                        list: List.generate(
                                          _controller.storyList[index].length,
                                          (subIndex) => StoryItem(
                                            AppCacheImage(
                                              imageUrl: _controller
                                                      .storyList[index]
                                                          [subIndex]
                                                      .fileUrl ??
                                                  '',
                                              width: double.infinity,
                                              height: double.infinity,
                                              round: 0,
                                              boxFit: BoxFit.fitWidth,
                                            ),
                                            duration:
                                                const Duration(seconds: 5),
                                          ),
                                        ).toList(),
                                        storyModel:
                                            _controller.storyList[index].first,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 74,
                                    width: 74,
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffC4C4C4)
                                          .withOpacity(.23),
                                      borderRadius: BorderRadius.circular(37),
                                      border: Border.all(
                                          color: AppColors.themeColor,
                                          width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(_controller
                                                .storyList[index]
                                                .first
                                                .fileUrl ??
                                            ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 29),
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'New members',
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: AppFonts.INTER_SEMIBOLD,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                GetBuilder<HomeScreenController>(
                    id: 'follow',
                    builder: (controller) {
                      if (_controller.followList.isEmpty &&
                          _controller.isFollowLoading.value == true) {
                        return const SizedBox(
                          height: 100,
                          child: NativeProgress(),
                        );
                      }
                      if (_controller.followList.isEmpty &&
                          _controller.isFollowLoading.value == false) {
                        return const SizedBox(
                          height: 100,
                          child: Center(child: Text('No New Members')),
                        );
                      }

                      if (_controller.followList.isNotEmpty &&
                          _controller.isFollowLoading.value == false) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(width: 16),
                                  ...List.generate(
                                    _controller.followList.length,
                                    (index) => FollowBox(
                                      userModel: _controller.followList[index],
                                      index: index,
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
              ],
            ),
            const SizedBox(height: 21),
            const DateBox(),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
