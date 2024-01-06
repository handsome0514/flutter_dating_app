// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

extension MyDate on DateTime {
  String get dd_mm_yyyy {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String get lastActive {
    return 'last seen at ${DateFormat('dd-MM-yyyy hh:mm a').format(this)}';
  }

  String get hh_mm_a {
    return DateFormat('hh:mm a').format(this);
  }
}

String createThreadId(String s1, String s2) {
  return s1.compareTo(s2) >= 0 ? "${s1}__$s2" : "${s2}__$s1";
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);

  // var p = 0.017453292519943295;
  // var c = cos;
  // var a = 0.5 -
  //     c((lat2 - lat1) * p) / 2 +
  //     c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  // return 12742 * asin(sqrt(a));
}

String kDateFormat(DateTime dateTime, String format) {
  final df = DateFormat(format);
  int myvalue = dateTime.microsecondsSinceEpoch;
  return df.format(dateTime);
  // print(df.format(DateTime.fromMillisecondsSinceEpoch(myvalue * 1000)));
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('-');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

extension DateExtension on DateTime {
  String formatDate(String format) {
    var now = this;
    var formatter = DateFormat(format);
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  bool get isNotCompletedCycle {
    var now = DateTime.now();
    var duration = difference(now).inHours;

    return duration != 24;
  }

  bool get withinTenDays {
    var now = DateTime.now();
    return now.difference(this).inHours < 240;
  }

  bool get isNotEighteenPlus {
    var now = DateTime.now();
    var age = now.difference(this).inDays ~/ 365;

    return age < 18;
  }

  bool isToday() {
    var now = DateTime.now();
    return (day == now.day && month == now.month && year == now.year);
  }

  bool isTomorrow() {
    var now = DateTime.now();
    print("************************************");

    print(day);
    print(now.day);
    return (day == (now.day + 1) && month == now.month && year == now.year);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  String kcapitalizeFirstLetter() {
    if ((length) == 0) return this;
    if ((length) == 1) return toUpperCase();
    return this[0].toUpperCase() + substring(1);
  }

  String kcapitalizeWord() {
    if ((length) == 0) return this;
    if ((length) == 1) return toUpperCase();
    var dataSplit = split(" ");
    print(dataSplit);
    var data = "";
    int index = 0;
    for (var word in dataSplit) {
      if (index == 0) {
        data = word;
      } else {
        data = "$data ${word.kcapitalizeFirstLetter()}";
      }
      index++;
    }
    return data;
  }

  bool isNumber() {
    try {
      var num = int.parse(this);
    } on Exception catch (e) {
      // TODO
      return false;
    }
    return true;
  }

  int toNumber() {
    try {
      var num = int.parse(this);
      return num;
    } on Exception catch (e) {
      // TODO
      return 0;
    }
  }
}

extension NumberParsing on int {
  double wRes(BuildContext context) {
    double originalWidth = 1920;
    double value = toDouble();
    double calculatedValue =
        (value / originalWidth) * MediaQuery.of(context).size.width;
/*    print(value.toString() +
        " => " +
        calculatedValue.toString() +
        " => w " +
        Get.size.width.toString());*/
    return calculatedValue < 10 ? 10 : calculatedValue;
  }

  double hRes(BuildContext context) {
    double originalHeight = 1080;
    double value = toDouble();
    double calculatedValue =
        (value / originalHeight) * MediaQuery.of(context).size.height;
/*    print(value.toString() +
        " => " +
        calculatedValue.toString() +
        " => h " +
        Get.size.height.toString());*/
    return calculatedValue < 10 ? 10 : calculatedValue;
  }
}

extension DoubleParsing on double {
  double wRes(BuildContext context) {
    double originalWidth = 1200;
    double value = this;
    double calculatedValue =
        (value / originalWidth) * MediaQuery.of(context).size.width;
    return calculatedValue < 10 ? 10 : calculatedValue;
  }

  double hRes(BuildContext context) {
    double originalHeight = 1080;
    double value = toDouble();
    double calculatedValue =
        (value / originalHeight) * MediaQuery.of(context).size.height;
/*    print(value.toString() +
        " => " +
        calculatedValue.toString() +
        " => h " +
        Get.size.height.toString());*/
    return calculatedValue < 10 ? 10 : calculatedValue;
  }
}

String kformatDate(DateTime dateTime) {
  String date = "";
  date = dateTime.day <= 9 ? "0${dateTime.day}" : dateTime.day.toString();
  date += "-";
  date +=
      dateTime.month <= 9 ? "0${dateTime.month}" : dateTime.month.toString();
  date += "-";
  date += dateTime.year <= 9 ? "0${dateTime.year}" : dateTime.year.toString();
  return date;
}

extension ListExtension<T> on List<T> {
  List<Widget> mapWithIndex(
      dynamic Function(dynamic element, int index) elementCallBack) {
    List<Widget> tempList = [];
    for (int i = 0; i < length; i++) {
      var widgets = elementCallBack.call(this[i], i);
      tempList.add(widgets);
    }
    return tempList;
  }

  List<T> mapList(T Function(dynamic element) elementCallBack) {
    List<T> outputList = [];
    List<Map<String, dynamic>> list = this as List<Map<String, dynamic>>;
    for (var listElement in list) {
      outputList.add(elementCallBack.call(listElement));
    }
    return outputList;
  }
}

extension MapExtension<T, U> on Map<T, U> {
  int getIndex(T value) {
    int index = 0;
    for (var item in keys.toList()) {
      if (item.toString().toLowerCase().contains(value.toString())) {
        return index;
      }
      index++;
    }
    return index;
  }

  T? getkey(int selectedIndex) {
    int index = 0;
    for (var item in keys.toList()) {
      if (index == selectedIndex) return item;
      index++;
    }
    return null;
  }

  U? getValue(int selectedIndex) {
    int index = 0;
    for (var item in keys.toList()) {
      if (index == selectedIndex) return this[item];
      index++;
    }
    return null;
  }
}
