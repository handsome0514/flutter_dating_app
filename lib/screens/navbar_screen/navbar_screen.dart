import 'package:bematched/screens/favourites_screen/favorites_screen.dart';
import 'package:bematched/screens/home_screen/home_screen.dart';
import 'package:bematched/screens/inbox_screen/inbox_screen.dart';
import 'package:bematched/screens/navbar_screen/navbar_screen_controller.dart';
import 'package:bematched/screens/personal_profile_screen/personal_profile_screen.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config.dart';

class NavBarScreen extends StatelessWidget {
  NavBarScreen({super.key});

  final _controller = Get.put(NavBarScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      key: _controller.scaffoldKey,
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _controller.selectedIndex.value,
                children: [
                  HomeScreen(),
                  FavoritesScreen(),
                  InboxScreen(),
                  PersonalProfileScreen(),
                ],
              ),
            ),
            Container(
              height: 72,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 21, left: 18, right: 18),
              padding: const EdgeInsets.only(
                  top: 14, bottom: 14, left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: AppColors.themeColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _controller.navbarList.length,
                  (index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _controller.onSelection(index),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _controller.selectedIndex.value == index
                                ? const Color(0xffEBEAEB)
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 10, right: 10),
                          child: Center(
                            child: SvgPicture.asset(
                              _controller.selectedIndex.value == index
                                  ? _controller.navbarList[index]['active']
                                  : _controller.navbarList[index]['inactive'],
                              height: 20,
                              width: 23,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        if (index == 2 && _controller.messageCount.value != 0)
                          Positioned(
                            top: -2,
                            right: -1,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: AppColors.whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  _controller.messageCount.value.toString(),
                                  style: const TextStyle(
                                    fontSize: 10.81,
                                    fontFamily: AppFonts.INTER_REGULAR,
                                    color: AppColors.themeColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
