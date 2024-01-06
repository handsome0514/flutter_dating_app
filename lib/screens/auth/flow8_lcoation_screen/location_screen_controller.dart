import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import '../../admin_base_controller.dart';
import 'package:location/location.dart' as location;

import '../../navbar_screen/navbar_screen.dart';

class LocationScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  newLatLng? currentLocation;
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isNotPermision = Rx(false);

  void setLocation() async {
    try {
      _baseController.showProgress();
      var userModel = AdminBaseController.userData.value;
      if (currentLocation != null) {
        var address = await placemarkFromCoordinates(
            currentLocation!.latitude!, currentLocation!.longitude!);
        var first = address.first;
        userModel.location =
            ' ${first.locality}, ${first.subLocality},${first.thoroughfare}, ${first.country}';
      }

      userModel
        ..flow = 8
        ..longitude = currentLocation?.longitude
        ..latitude = currentLocation?.latitude
        ..firstRegister = Timestamp.now();
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.offAll(() => NavBarScreen());
    } catch (e) {
      _baseController.hideProgress();
      print(e);
    }
  }

  @override
  void onInit() async {
    try {
      isLoading.value = true;
      var newLocation = await location.Location.instance.getLocation();
      currentLocation = newLatLng()
        ..latitude = newLocation.latitude
        ..longitude = newLocation.longitude;
      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        isLoading.value = false;
        isNotPermision.value = true;
        print(e);
      }
    }

    // TODO: implement onInit
    super.onInit();
  }
}
