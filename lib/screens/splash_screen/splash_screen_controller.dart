import 'package:bematched/config.dart';
import 'package:bematched/screens/welcome_screen/welcome_screen.dart';
import '../../network_service/network_services.dart';
import '../../payment_service/revenue_cat.dart';
import '../../utils/data_cache.dart';
import '../admin_base_controller.dart';

class SplashScreenController extends GetxController {
  //*******************************************************************
  void initData() async {
    //*******************************************************************
    try {
     // await RevenueCat.initPlatformState();
      await DataCache.init();

      if (await NetWorkServices.getUserDetail() != null) {
        var user = AdminBaseController.userData.value;
        navigateToScreen(user.flow ?? 0);
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      initData();
    });
    super.onInit();
  }
}
