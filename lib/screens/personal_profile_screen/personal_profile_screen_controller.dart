import 'package:bematched/config.dart';
import 'package:bematched/models/thread_model.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalProfileScreenController extends GetxController {
  var userModel = AdminBaseController.userData.value;
  Rx<int> selectedIndex = Rx(0);
  int matchCount = 0;
  int followingCount = 0;
  int threadCount = 0;

  List<String> stringList = ['Pictures', 'My Bio'];

  void updateUserModel() {
    userModel = AdminBaseController.userData.value;

    update();
  }

  void loadCount() async {
    matchCount = userModel.matches?.length ?? 0;
    followingCount = userModel.followers?.length ?? 0;
    var doc = await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .where('participant_user_list', arrayContains: userModel.uid)
        .get();
    if (doc.docs.isNotEmpty) {
      threadCount = doc.docs.length;
    }
    update();
  }

  @override
  void onInit() {
    loadCount();
    // TODO: implement onInit
    super.onInit();
  }
}
