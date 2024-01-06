import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreenController extends GetxController {
  List<String> optionList = ['All', 'New', 'Nearby', 'Online', 'Liked You'];
  Rx<int> selectedOption = Rx(0);
  bool isLoading = false;
  List<UserModel> usersList = [];
  List<UserModel> newUsers = [];
  List<UserModel> nearbyUsers = [];
  List<UserModel> onlineUsers = [];
  List<UserModel> likedYouUsers = [];

  void loadOtherLikeList() async {
    var uid = AdminBaseController.userData.value.uid;
    FirebaseFirestore.instance
        .collection(UserModel.TABLE_NAME)
        .doc(uid)
        .snapshots()
        .listen((event) async {
      usersList.clear();
      newUsers.clear();
      nearbyUsers.clear();
      onlineUsers.clear();
      likedYouUsers.clear();
      if (event.exists) {
        var list = UserModel.fromJson(event.data()!).otherLikes;
        for (var uid in list ?? []) {
          var user = await UserModel.getUserDetail(uid);
          if (user != null) {
            if (user.distance <= 10) {
              nearbyUsers.add(user);
            } else if (user.chatStatus == ChatStatus.online.index) {
              onlineUsers.add(user);
            } else if (DateTime.now()
                    .difference(user.firstRegister?.toDate() ?? DateTime.now())
                    .inHours <
                240) {
              newUsers.add(user);
            } else {
              likedYouUsers.add(user);
            }

            usersList.add(user);
          }
        }
        update();
      }
    });
  }

  @override
  void onInit() {
    loadOtherLikeList();
    // TODO: implement onInit
    super.onInit();
  }
}
