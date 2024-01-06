import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  final Permission permission;
  final String permissionName;
  final BuildContext context;

  static Future<bool> get isPrecise async {
    final accuracyStatus = await Geolocator.getLocationAccuracy();

    bool isPrecise = false;
    switch (accuracyStatus) {
      case LocationAccuracyStatus.reduced:
        log("approximate");
        break;
      case LocationAccuracyStatus.precise:
        // Precise location switch is ON.
        log("precise");
        isPrecise = true;

        break;
      case LocationAccuracyStatus.unknown:
        log("unknonwn");
        // The platform doesn't support this feature, for example an Android device.
        break;
    }
    return isPrecise;
  }

  PermissionUtils(
      {required this.permission,
      required this.permissionName,
      required this.context});

  Future<bool> get isAllowed async {
    var startTime = DateTime.now();
    var status = await permission.request();
    var endTime = DateTime.now();
    var waitTime = startTime.difference(endTime).inSeconds.abs();
    log(waitTime.toString());

    log(status.toString());
    /*  if (Platform.isIOS && status == permission.isLimited) {
      return true;
    }*/
    String messages = "";
    if (permission.value == Permission.location.value) {
      messages = "Please turn on precise location.";
    }
    // if (!status.isGranted && (status.isDenied || status.isPermanentlyDenied)) {
    if (/*!status.isGranted || status.isDenied || */ status
            .isPermanentlyDenied &&
        waitTime <= 1) {
      var result = await showOkCancelAlertDialog(
          context: context,
          title: "Permission Error",
          message:
              "You denied permission. Please allow $permissionName permission from setting.${messages}Open setting now?",
          okLabel: "Yes",
          cancelLabel: "No");
      if (result == OkCancelResult.ok) {
        openAppSettings();
      }
      return false;
    }

    log(permission.status.toString());
    return status.isGranted;
  }
}
