import 'package:get/get.dart';
import '../models/user_model.dart';

//*******************************************************************
class AdminBaseController
    extends GetxController //*******************************************************************
{
  var userModel = UserModel().obs;
  List<String> heightOptions = [];
  List<String> educationLevelOptions = [];
  List<String> drinkingOptions = [];
  List<String> smokingOptions = [];
  List<String> relationshipOptions = [];
  List<String> zodiacSignOptions = [];
  List<String> industryOptions = [];
  List<String> yearsOfExperienceOptions = [];

  //*******************************************************************

  //*******************************************************************

  //*******************************************************************
  static void updateUser(UserModel userModel) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.userModel.value = userModel;
    userController.update();
  }

  //*******************************************************************
  static void updateHeightOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.heightOptions = options;
    userController.update();
  }

  //*******************************************************************
  static void updateEducationLevelOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.educationLevelOptions = options;
    userController.update();
  }

  //*******************************************************************
  static void updateDrinkingOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.drinkingOptions = options;
    userController.update();
  } //*******************************************************************

  static void updateSmokingOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.smokingOptions = options;
    userController.update();
  } //*******************************************************************

  static void updateRelationShipOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.relationshipOptions = options;
    userController.update();
  } //*******************************************************************

  static void updateZodiacSignOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.heightOptions = options;
    userController.update();
  } //*******************************************************************

  static void updateIndustryOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.heightOptions = options;
    userController.update();
  } //*******************************************************************

  static void updateYearsOfExperienceOptions(List<String> options) {
    //*******************************************************************
    var userController = Get.put(AdminBaseController());
    userController.heightOptions = options;
    userController.update();
  }

  static Rx<UserModel> get userData {
    return Get.put(AdminBaseController()).userModel;
  }

  static List<String> get heightOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get educationLevelOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get drinkingOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get smokingOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get relationshipOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get zodiacSignOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get industryOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }

  static List<String> get yearsOfExperienceOptionsData {
    return Get.put(AdminBaseController()).heightOptions;
  }
}
