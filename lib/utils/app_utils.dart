// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:ui' as ui;

class AppUtils {
  static Future<List<File>> pickImages(
      {int? pickItems, required Sources source}) async {
    List<File> files = [];
    if (source == Sources.Camera) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        var request = await Permission.camera.request();
        if (request.isDenied) return files;
      }
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return files;
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(image.path);
      File compressedFile = await FlutterNativeImage.compressImage(image.path,
          quality: 100,
          targetWidth: 900,
          targetHeight: (properties.height! * 900 / properties.width!).round());
      files.add(compressedFile);

      return files;

      /// use [Permissions.photos.status]
    } else {
      if (Platform.isAndroid) {
        log('Reading device info');
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          log('SDK version is smaller than 32');
          var status = await Permission.storage.status;
          if (status.isDenied) {
            var request = await Permission.storage.request();
            if (request.isDenied) return files;
          }
          var images =
              await ImagesPicker.pick(count: pickItems ?? 1, gif: false);
          if (images == null) return files;
          for (var image in images) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(image.path);
            File compressedFile = await FlutterNativeImage.compressImage(
                image.path,
                quality: 100,
                targetWidth: 900,
                targetHeight:
                    (properties.height! * 900 / properties.width!).round());
            files.add(compressedFile);
          }
          return files;
        } else {
          log('SDK version is greater than 32');
          var status = await Permission.photos.status;
          log('status ${status.isGranted}');
          if (status.isDenied) {
            var request = await Permission.photos.request();
            log('request status: ${request.isGranted}');
            if (request.isDenied) return files;
          }
          // For Single Image Selection at Android 13

          if ((pickItems ?? 1) == 1) {
            var image =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image == null) return files;
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(image.path);
            File compressedFile = await FlutterNativeImage.compressImage(
                image.path,
                quality: 100,
                targetWidth: 900,
                targetHeight:
                    (properties.height! * 900 / properties.width!).round());
            files.add(compressedFile);
            return files;
          }

          // For Multi Image Selection at Android 13

          List<XFile> images = await ImagePicker().pickMultiImage();
          if (images.isEmpty) return files;
          if (images.length > pickItems!) {
            showOkAlertDialog(
                context: Get.context!,
                title: 'Invalid Selection',
                message:
                    'You cannot select more than $pickItems.Please re-select the images');
            return files;
          }
          for (var image in images) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(image.path);
            File compressedFile = await FlutterNativeImage.compressImage(
                image.path,
                quality: 100,
                targetWidth: 900,
                targetHeight:
                    (properties.height! * 900 / properties.width!).round());
            files.add(compressedFile);
          }
          return files;
        }
      }
      var status = await Permission.photos.status;
      if (status.isDenied) {
        var request = await Permission.photos.request();
        if (request.isDenied) return files;
      }
      // var image = await ImagesPicker.pick(count: pickItems ?? 1, gif: false);
      return files;
    }
  }
}

enum Sources { Camera, Gallery }
