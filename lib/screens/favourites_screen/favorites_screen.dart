import 'package:bematched/screens/favourites_screen/favorites_screen_controller.dart';
import 'package:bematched/screens/favourites_screen/like_box.dart';
import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/screens/navbar_screen/navbar_screen_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:flutter_svg/svg.dart';

import '../../config.dart';
import '../../utils/base_controller.dart';
import '../../widgets/filter_bottomsheet.dart';
import '../../widgets/no_record_found.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final _controller = Get.put(FavoritesScreenController());
  final _navController = Get.find<NavBarScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (_navController.scaffoldKey.currentState!.isDrawerOpen) {
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
        title: const Text(
          'Interested in you',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
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
/*      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            CustomDailogs.okSuccessAlertDialog(context, 'Your Password has been changed');
          },
          child: SvgPicture.asset(
            SvgAssets.SEARCH_ICON,
            height: 22,
            width: 22,
            fit: BoxFit.scaleDown,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(SvgAssets.BELL_ICON),
          ),
        ],
      ),*/
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 42),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _controller.optionList.length,
                (index) => Obx(
                  () => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _controller.selectedOption.value = index;
                      _controller.update();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _controller.selectedOption.value == index
                                ? AppColors.themeColor
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        _controller.optionList[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: _controller.selectedOption.value == index
                              ? AppColors.themeColor
                              : AppColors.BLACK,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 33),
            GetBuilder<FavoritesScreenController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return NativeProgress();
                }
                if (controller.isLoading == false &&
                    controller.usersList.isEmpty) {
                  return const NoRecordFound();
                }
                if (controller.selectedOption.value == 1) {
                  return LikeBox(userList: controller.newUsers);
                }
                if (controller.selectedOption.value == 2) {
                  return LikeBox(userList: controller.nearbyUsers);
                }
                if (controller.selectedOption.value == 3) {
                  return LikeBox(userList: controller.onlineUsers);
                }
                return LikeBox(userList: controller.usersList);
              },
            ),
          ],
        ),
      ),
    );
  }
}
