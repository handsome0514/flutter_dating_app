import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../screens/admin_base_controller.dart';

class UserModel {
  static String TABLE_NAME = "Users";
  String? uid;
  String? email;
  String? phoneNumber;
  String? location;
  int? connectionStatus;
  String? name;
  int? flow;
  int? chatStatus;
  Timestamp? lastActive;
  int? isVerified;
  String? password;
  String? profileImage;
  double? latitude;
  double? longitude;
  Timestamp? dob;
  int? myGender;
  List<dynamic>? interest;
  String? work;
  String? height;
  String? drinking;
  String? smoking;
  String? zodiacSign;
  String? relationship;
  String? industry;
  String? yearsOfExperience;
  String? educationLevel;
  bool? isDate;

  List<dynamic>? images;
  String? bios;

  int? memberShipType;
  List<dynamic>? myLikes;
  List<dynamic>? otherLikes;
  List<dynamic>? matches;
  List<dynamic>? myDisLikes;
  List<dynamic>? otherDislikes;
  List<dynamic>? followers;
  List<dynamic>? following;
  int? likes;
  bool? isDeleted;
  bool? isBlocked;
  Timestamp? updatedTime;
  Timestamp? firstRegister;
  static int MEMBER_PREMIUM_NON = 0;
  static int MEMBER_PREMIUM_12 = 1;
  static int MEMBER_PREMIUM_6 = MEMBER_PREMIUM_12 + 1;
  static int MEMBER_PREMIUM_3 = MEMBER_PREMIUM_6 + 1;
  static int MEMBER_PREMIUM_1 = MEMBER_PREMIUM_3 + 1;

  UserModel({this.email, this.flow, this.password, this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    connectionStatus = json['connectionStatus'] ?? 0;
    name = json['name'];
    location = json['location'];
    flow = json['flow'];
    chatStatus = json['chatStatus'] ?? 0;
    lastActive = json['lastActive'];
    isVerified = json['isVerified'] ?? 0;
    uid = json['uid'];
    updatedTime = json['updatedTime'];
    profileImage = json['profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    dob = json['dob'];
    myGender = json['my_gender'];
    interest = json['interest'];
    work = json['work'];
    height = json['height'];
    drinking = json['drinking'];
    smoking = json['smoking'];
    zodiacSign = json['zodiacSign'];
    isDate = json['isDate'] ?? true;
    firstRegister = json['firstRegister'];
    relationship = json['relationship'];
    industry = json['industry'];
    yearsOfExperience = json['yearsOfExperience'];
    educationLevel = json['educationLevel'];
    images = json['images'];
    bios = json['bios'];

    memberShipType = json['member_ship_type'] ?? 0;

    myLikes = json['myLikes'] ?? [];
    otherLikes = json['otherLikes'] ?? [];
    myDisLikes = json['myDisLikes'] ?? [];
    otherDislikes = json['otherDislikes'] ?? [];
    matches = json['matches'] ?? [];
    followers = json['followers'] ?? [];
    following = json['following'] ?? [];

    likes = json['likes'] ?? 0;
    isDeleted = json['isDeleted'] ?? false;
    isBlocked = json['isBlocked'] ?? false;

    if ((isDeleted ?? false) || (profileImage?.isEmpty ?? true)) {
      profileImage = "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['connectionStatus'] = connectionStatus ?? 0;
    data['name'] = name;
    data['location'] = location;
    data['flow'] = flow;
    data['chatStatus'] = chatStatus;
    data['lastActive'] = lastActive;
    data['isVerified'] = isVerified;
    data['uid'] = uid;
    data['profile_image'] = profileImage;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['dob'] = dob;
    data['my_gender'] = myGender;
    data['interest'] = interest ?? [];

    data['work'] = work;

    data['height'] = height;

    data['drinking'] = drinking;
    data['smoking'] = smoking;
    data['zodiacSign'] = zodiacSign;
    data['isDate'] = isDate;
    data['firstRegister'] = firstRegister;
    data['relationship'] = relationship;
    data['industry'] = industry;
    data['yearsOfExperience'] = yearsOfExperience;
    data['educationLevel'] = educationLevel;
    data['images'] = images ?? [];
    data['bios'] = bios;

    data['member_ship_type'] = memberShipType ?? 0;

    data['myLikes'] = myLikes ?? [];
    data['otherLikes'] = otherLikes ?? [];
    data['myDisLikes'] = myDisLikes ?? [];
    data['otherDislikes'] = otherDislikes ?? [];
    data['matches'] = matches ?? [];
    data['followers'] = followers;
    data['following'] = following;

    data['likes'] = likes ?? 0;
    data['isDeleted'] = isDeleted ?? false;
    data['isBlocked'] = isBlocked ?? false;

    return data;
  }

  int get percentage {
    int count = 30;
    if (bios?.isNotEmpty ?? false) {
      count = count + 10;
    }
    if (isVerified == 2) {
      count = count + 30;
    }
    if (work?.isNotEmpty ?? false) {
      count = count + 10;
    }

    if (connectionStatus == 0) {
      if (height?.isNotEmpty ?? false) {
        count = count + 3;
      }
      if (educationLevel?.isNotEmpty ?? false) {
        count = count + 3;
      }

      if (drinking?.isNotEmpty ?? false) {
        count = count + 3;
      }
      if (smoking?.isNotEmpty ?? false) {
        count = count + 3;
      }
      if (relationship?.isNotEmpty ?? false) {
        count = count + 3;
      }
      if (industry?.isNotEmpty ?? false) {
        count = count + 3;
      }
      if (zodiacSign?.isNotEmpty ?? false) {
        count = count + 2;
      }
    } else if (connectionStatus == 1) {
      if (educationLevel?.isNotEmpty ?? false) {
        count = count + 4;
      }

      if (drinking?.isNotEmpty ?? false) {
        count = count + 4;
      }
      if (smoking?.isNotEmpty ?? false) {
        count = count + 4;
      }
      if (industry?.isNotEmpty ?? false) {
        count = count + 4;
      }
      if (zodiacSign?.isNotEmpty ?? false) {
        count = count + 4;
      }
    } else if (connectionStatus == 2) {
      if (educationLevel?.isNotEmpty ?? false) {
        count = count + 7;
      }
      if (industry?.isNotEmpty ?? false) {
        count = count + 7;
      }
      if (yearsOfExperience?.isNotEmpty ?? false) {
        count = count + 6;
      }
    }

    return count;
  }

  List<String> get heartCount {
    Set<String> count = <String>{};
    print("matches$matches");
    otherLikes?.forEach((element) {
      if (!matches!.contains(element)) count.add(element);
    });
    /*otherSuperLikes?.forEach((element) {
      if (!matches!.contains(element)) count.add(element);
    });
    */
    return count.toList();
  }

  Future addNewUserOrUpdate() async {
    await FirebaseFirestore.instance
        .collection(TABLE_NAME)
        .doc(uid!)
        .set(toJson(), SetOptions(merge: true));
  }

  static Future<UserModel?> getUserDetail(String uid) async {
    print(uid);
    UserModel? userModel;
    try {
      var snapShot = await FirebaseFirestore.instance
          .collection(TABLE_NAME)
          .doc(uid)
          .get();
      if (!snapShot.exists) return null;
      print(snapShot.data());
      userModel = UserModel.fromJson(snapShot.data() ?? {});
      if (userModel.uid == (FirebaseAuth.instance.currentUser?.uid ?? "")) {
        AdminBaseController.updateUser(userModel);
      }
    } on Exception catch (e) {
      throw e.toString();
    }

    return userModel;
  }

  int get age {
    return DateTime.now().difference(dob?.toDate() ?? DateTime.now()).inDays ~/
        365;
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, flow: $flow, password: $password, profileImage: $profileImage, latitude: $latitude, longitude: $longitude, dob: $dob, myGender: $myGender, interest: $interest, images: $images, memberShipType: $memberShipType}';
  }

  int get distance {
    var user = AdminBaseController.userData.value;
    return ((Geolocator.distanceBetween(latitude ?? 0, longitude ?? 0,
                user.latitude ?? 0, user.longitude ?? 0)) *
            0.000621371)
        .toInt();
  }

  bool isLiked(String uid) {
    print(myLikes);

    if (myLikes == null) {
      return false;
    }
    print(myLikes!.contains(uid));

    return myLikes!.contains(uid);
  }

  bool isMatched(String uid) {
    print(matches);

    if (matches == null) {
      return false;
    }
    print(matches!.contains(uid));

    return matches!.contains(uid);
  }

  bool isDisLiked(String uid) {
    print(myDisLikes);
    if (myDisLikes == null) {
      return false;
    }
    print(myDisLikes!.contains(uid));
    return myDisLikes!.contains(uid);
  }

  static String getHeight(double height) {
    var feet = (height / 13) + 3;
    var inches = (height % 13);
    return "${feet.toInt()}’’${inches.toInt()}’";
  }

  int checkString(String? value) {
    if (value?.isNotEmpty ?? false) {
      return 1;
    }
    return 0;
  }

  int checkDoubleNumber(double? number) {
    if (number != null && number >= 0) {
      return 1;
    }
    return 0;
  }

  int checkNumber(int? number) {
    if (number != null && number >= 0) {
      return 1;
    }
    return 0;
  }

/*  void updatePosition() {
    final geo = Geoflutterfire();
    GeoFirePoint myLocation =
        geo.point(latitude: latitude!, longitude: longitude!);
    point = LocationPoint()
      ..geoHash = myLocation.hash
      ..geoPoint = myLocation.geoPoint;
  }*/
}

class LocationPoint {
  String? geoHash;
  GeoPoint? geoPoint;

  LocationPoint();

  LocationPoint.fromJson(Map<String, dynamic> json) {
    geoHash = json['geohash'];
    geoPoint = json['geopoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['geohash'] = geoHash;
    data['geopoint'] = geoPoint;
    return data;
  }
}

class newLatLng {
  double? latitude;
  double? longitude;
}
