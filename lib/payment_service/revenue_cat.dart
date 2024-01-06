import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

import '../models/user_model.dart';
import '../network_service/network_services.dart';
import '../screens/admin_base_controller.dart';

class RevenueCat {
  static Future<void> initPlatformState() async {
    var packages = {
      "beMatch_120_1y": UserModel.MEMBER_PREMIUM_12,
      "beMatch_90_6m": UserModel.MEMBER_PREMIUM_6,
      "beMatch_90_3m": UserModel.MEMBER_PREMIUM_3,
      "beMatch_90_1m": UserModel.MEMBER_PREMIUM_1
    };

    const googleApi = '';
    const appleApi = '';

    await Purchases.setDebugLogsEnabled(true);
    PurchasesConfiguration configuration;
    configuration =
        PurchasesConfiguration(Platform.isAndroid ? googleApi : appleApi);
    await Purchases.configure(configuration);
    await Purchases.enableAdServicesAttributionTokenCollection();
    Purchases.addCustomerInfoUpdateListener((purchaserInfo) async {
      print("customer_info $purchaserInfo");

      print("cutomer->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      var isPurchases =
          purchaserInfo.entitlements.all["ever_premium"]?.isActive ?? false;
      if (purchaserInfo.activeSubscriptions.isNotEmpty) {
        if (AdminBaseController.userData.value.memberShipType !=
            UserModel.MEMBER_PREMIUM_NON) {
          return;
        }

        var activeSubscription =
            isPurchases ? purchaserInfo.activeSubscriptions.first : "";
        print("customer_info${purchaserInfo.activeSubscriptions}");
        // print(purchaserInfo.allExpirationDates);
        // print(purchaserInfo.allPurchaseDates);
        // print(purchaserInfo.entitlements.active);
        print("customer_info${isPurchases.toString() ?? ""}");

        await NetWorkServices.updateMemberShip(
            packages[purchaserInfo.activeSubscriptions.first] ?? 0,
            AdminBaseController.userData.value.uid!);
      } else {
        if (AdminBaseController.userData.value.memberShipType ==
            UserModel.MEMBER_PREMIUM_NON) {
          return;
        }

        await NetWorkServices.updateMemberShip(UserModel.MEMBER_PREMIUM_NON,
            AdminBaseController.userData.value.uid!);
      }
    });
  }
}
