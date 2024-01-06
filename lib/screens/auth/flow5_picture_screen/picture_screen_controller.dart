import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bematched/config.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/extension.dart';

import '../../../network_service/network_services.dart';
import '../../../widgets/custom_dailogs.dart';
import '../flow6_interest_screen/interest_screen.dart';

class PictureScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  RxList<String> pathList = RxList();

  void picker() async {
    var files = await CustomDailogs.photo_picker(Get.context!,
        maxPhoto: (15 - pathList.length));
    if (files.isNotEmpty) {
      pathList.addAll(files.map((e) => e.path).toList());
    }
  }

  void deSelectItem(int index) {
    pathList.removeAt(index);
  }

  void setImages() async {
    if (pathList.isEmpty) {
      CustomDailogs.okErrorAlertDialog(Get.context!, 'Please Select at least one image');
      return;
    }
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      userModel
        ..flow = 5
        ..profileImage = await NetWorkServices.uploadUserImage(
            userModel.uid!, pathList.first);
      pathList.removeAt(0);
      var list = [];
      for (var path in pathList) {
        var url =
            await NetWorkServices.uploadImage(generateRandomString(15), path);
        list.add(url);
      }
      userModel.images = list;
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.to(() => InterestScreen(isBack: true));
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }
}
