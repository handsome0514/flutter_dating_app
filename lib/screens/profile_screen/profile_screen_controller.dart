import 'package:bematched/config.dart';
import 'package:bematched/models/user_model.dart';

class ProfileScreenController extends GetxController {
  ProfileScreenController(this.userModel);

  UserModel userModel = UserModel();
}
