import 'dart:convert';
import '../utils/data_cache.dart';

class HomeFilterModel {
  List<int>? selectedLanguage;
  int? interestedIn;
  int? distance;
  Age? age;
  bool? useLocation;


  HomeFilterModel({this.distance, this.age});

  HomeFilterModel.fromJson(Map<String, dynamic> json) {
    selectedLanguage = json['selectedLanguage']?.cast<int>() ?? [];
    interestedIn = json['interested_in']??0;
    distance = json['distance'];
    age = json['age'] != null ? Age.fromJson(json['age']) : null;
    useLocation = json['useLocation']??true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedLanguage'] = selectedLanguage;
    data['interested_in'] = interestedIn;
    data['distance'] = distance;
    if (age != null) {
      data['age'] = age!.toJson();
    }
    data['useLocation'] = useLocation;
    return data;
  }

  void update() {
    var json1 = json.encode(toJson());
    DataCache.data.setString(DataCache.USER_FILTER, json1);
  }

  static HomeFilterModel getUser() {
    String text = DataCache.data.getString(DataCache.USER_FILTER) ?? "";
    if (text.isEmpty) {
      HomeFilterModel.initFilter();
      text = DataCache.data.getString(DataCache.USER_FILTER) ?? "";
    }
    return HomeFilterModel.fromJson(jsonDecode(text) as Map<String, dynamic>);
  }

  static void initFilter() {
    var age = Age()
      ..start = 18
      ..end = 30;
    var filter = HomeFilterModel()
      ..distance = 50
      ..interestedIn = 0
      ..age = age;
    filter.update();
  }

  @override
  String toString() {
    return 'UserFilterModel{distance: $distance, age: $age}';
  }
}

class Age {
  int? start;
  int? end;

  Age({this.start, this.end});

  Age.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }

  @override
  String toString() {
    return 'Age{start: $start, end: $end}';
  }
}
