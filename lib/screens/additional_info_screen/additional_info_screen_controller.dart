import 'package:bematched/config.dart';
import 'package:bematched/models/option_model.dart';
import 'package:bematched/models/user_model.dart';
import 'package:bematched/network_service/network_services.dart';
import 'package:bematched/screens/admin_base_controller.dart';
import 'package:bematched/screens/personal_profile_screen/personal_profile_screen_controller.dart';
import 'package:bematched/utils/base_controller.dart';
import 'package:bematched/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdditionalInfoScreenController extends GetxController {
  final _baseController = BaseController(Get.context, () {});
  var userModel = AdminBaseController.userData.value;
  Rx<String> height = ''.obs;
  Rx<String> educationLevel = ''.obs;
  Rx<String> drinking = ''.obs;
  Rx<String> smoking = ''.obs;
  Rx<String> relationship = ''.obs;
  Rx<String> zodiacSign = ''.obs;
  Rx<String> industry = ''.obs;
  Rx<String> yearOfExperience = ''.obs;
  Rx<String> work = ''.obs;

  List<String> heightList = [];
  List<String> educationLevelList = [];
  List<String> drinkingList = [];
  List<String> smokingList = [];
  List<String> relationshipList = [];
  List<String> zodiacSignList = ZodiacSigns.values.map((e) => e.name).toList();
  List<String> industryList = [];
  List<String> yearOfExperienceList = [];

  initData() {
    var userModel = AdminBaseController.userData.value;
    height.value = userModel.height ?? '';
    educationLevel.value = userModel.educationLevel ?? '';
    drinking.value = userModel.drinking ?? '';
    smoking.value = userModel.smoking ?? '';
    relationship.value = userModel.relationship ?? '';
    zodiacSign.value = userModel.zodiacSign ?? '';
    industry.value = userModel.industry ?? '';
    yearOfExperience.value = userModel.yearsOfExperience ?? '';
    work.value = userModel.work ?? '';
  }

  @override
  void onInit() async {
    initData();
    loadOptions();
    // TODO: implement onInit
    super.onInit();
  }

  void loadOptions() {
    heightList.addAll(AdminBaseController.heightOptionsData);
    educationLevelList.addAll(AdminBaseController.educationLevelOptionsData);
    drinkingList.addAll(AdminBaseController.drinkingOptionsData);
    smokingList.addAll(AdminBaseController.smokingOptionsData);
    relationshipList.addAll(AdminBaseController.relationshipOptionsData);
    zodiacSignList.addAll(AdminBaseController.zodiacSignOptionsData);
    industryList.addAll(AdminBaseController.industryOptionsData);
    yearOfExperienceList
        .addAll(AdminBaseController.yearsOfExperienceOptionsData);
  }

  void submit() {
    var userModel = AdminBaseController.userData.value;

    userModel = userModel
      ..height = height.value
      ..educationLevel = educationLevel.value
      ..drinking = drinking.value
      ..smoking = smoking.value
      ..relationship = relationship.value
      ..zodiacSign = zodiacSign.value
      ..industry = industry.value
      ..yearsOfExperience = yearOfExperience.value
      ..work = work.value;

    try {
      _baseController.showProgress();
      userModel.addNewUserOrUpdate();
      AdminBaseController.updateUser(userModel);
      final ctrl = Get.find<PersonalProfileScreenController>();
      ctrl.updateUserModel();
      _baseController.hideProgress();
      Get.back();
    } catch (e) {
      print(e);
    }
  }
}
