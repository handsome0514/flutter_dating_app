import 'package:bematched/config.dart';
import 'package:bematched/models/thread_model.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/chat_screen/chat_screen.dart';
import 'package:bematched/screens/navbar_screen/navbar_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../network_service/network_services.dart';
import '../../utils/extension.dart';

class MatchScreenController extends GetxController {
  MatchScreenController(this.likee);

  UserModel likee = UserModel();
  UserModel liker = AdminBaseController.userData.value;

  ThreadModel? threadModel;

  void goToChatScreen() {
    Get.back();
    final ctrl = Get.find<NavBarScreenController>();
    ctrl.selectedIndex.value = 2;
    ctrl.update();
    if (threadModel != null) {
      Get.to(
        () => ChatScreen(threadModel: threadModel!),
        transition: Transition.rightToLeft,
      );
    }
  }

  void loadThreadModel() async {
    var threadId = createThreadId(likee.uid!, liker.uid!);
    var doc = await FirebaseFirestore.instance
        .collection(ThreadModel.TABLE_NAME)
        .doc(threadId)
        .get();
    if (doc.data() != null) {
      var thread = ThreadModel.fromJson(doc.data()!);
      var userModel = await NetWorkServices.getUserDetailById(
          thread.participantUserList![0] ==
              AdminBaseController.userData.value.uid
              ? thread.participantUserList![1]
              : thread.participantUserList![0]);
      if (userModel != null) {
        thread.userDetail = userModel;
      }
      threadModel = thread;
    }
  }

  @override
  void onInit() {
    loadThreadModel();
    // TODO: implement onInit
    super.onInit();
  }
}
