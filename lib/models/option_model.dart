import 'package:cloud_firestore/cloud_firestore.dart';

class OptionModel {
  static String TABLE_NAME = "Stories";
  String? value;

  OptionModel();

  OptionModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}

enum OptionList {
  heightOption,
  educationLevelOption,
  drinkingOption,
  smokingOption,
  relationshipOption,
  zodiacSignOption,
  industryOption,
  yearsOfExperience,
}
