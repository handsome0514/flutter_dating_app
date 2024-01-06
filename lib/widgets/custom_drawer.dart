import 'package:bematched/screens/home_screen/home_screen_controller.dart';
import 'package:bematched/screens/navbar_screen/navbar_screen_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/connection_box.dart';
import 'package:bematched/widgets/singlechild_spacer_widget.dart';

import '../config.dart';
import '../screens/admin_base_controller.dart';
import '../screens/setting_screens/settings_screen/setting_screen.dart';
import '../utils/app_cache_image.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.75,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GetBuilder<AdminBaseController>(
        builder: (controller) => SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
              gradient: LinearGradient(colors: [
                Color(0xff7E1D96),
                Color(0xffEB4887),
              ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            ),
            child: SingleChildSpacerWidget(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppCacheImage(
                        imageUrl:
                            AdminBaseController.userData.value.profileImage ??
                                '',
                        width: 77,
                        height: 77,
                        round: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.53),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AdminBaseController.userData.value.name ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Padding(
                    padding: const EdgeInsets.only(left: 23, right: 17),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AdminBaseController.userData.value.location ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.whiteColor.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Choose a connection',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: AppFonts.INTER_SEMIBOLD,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    connectionList.length,
                    (index) => Obx(
                      () => ConnectionBox(
                        isSelected:
                            controller.userModel.value.connectionStatus ==
                                index,
                        title: connectionList[index]['title'],
                        description: connectionList[index]['des'],
                        onTap: () {
                          print('INdex>>$index');
                          controller.userModel.value.connectionStatus = index;
                          controller.userModel.value.addNewUserOrUpdate();
                          AdminBaseController.updateUser(
                              controller.userModel.value);
                          final ctrl = Get.find<NavBarScreenController>();
                          ctrl.scaffoldKey.currentState?.closeDrawer();
                          final homeCtrl = Get.find<HomeScreenController>();
                          homeCtrl.loadUser();
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(height: 52),
                  Divider(
                    color: AppColors.whiteColor.withOpacity(.2),
                    thickness: 1,
                  ),
                  const SizedBox(height: 21),
                  InkWell(
                    onTap: () {
                      Get.to(() => SettingScreen());
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 22.25),
                        Icon(
                          Icons.settings_outlined,
                          color: AppColors.whiteColor,
                          size: 25,
                        ),
                        SizedBox(width: 14.25),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            color: AppColors.whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 44),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
