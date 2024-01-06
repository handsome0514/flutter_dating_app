import 'dart:developer';

import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/favourites_screen/favorites_screen_controller.dart';
import 'package:flutter_draggable_gridview/constants/colors.dart';

import '../../config.dart';
import '../../widgets/like_widget.dart';
import '../home_screen/home_screen_controller.dart';

class LikeBox extends StatelessWidget {
  LikeBox({super.key, required this.userList});

  final List<UserModel> userList;
  final controller = Get.find<FavoritesScreenController>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 18, right: 18),
      shrinkWrap: true,
      itemCount: userList.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: .7,
      ),
      itemBuilder: (_, index) {
        return Dismissible(
            background: Container(
              color: AppColors.white,
            ),
            confirmDismiss: (detail) async {
              return true;
            },
            onDismissed: (details) {
              print(details);
              if (details == DismissDirection.endToStart) {
                final ctrlHome = Get.find<HomeScreenController>();
                ctrlHome.disLikeUser(userList[index]);
                controller.loadOtherLikeList();
                log('Rejected');
              }
              if (details == DismissDirection.startToEnd) {
                final ctrlHome = Get.find<HomeScreenController>();
                ctrlHome.likeUser(userList[index]);
                controller.loadOtherLikeList();
                log('Accepted');
              }
            },
            key: ValueKey<UserModel>(controller.usersList[index]),
            child: LikeWidget(userModel: userList[index]));
      },
    );
  }
}
