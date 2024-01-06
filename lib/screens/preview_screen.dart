import 'package:bematched/config.dart';
import 'package:bematched/utils/app_cache_image.dart';
import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.fileUrl});

  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: Get.back,
            child: const Icon(Icons.arrow_back, color: AppColors.whiteColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: AppCacheImage(
            imageUrl: fileUrl,
            width: double.infinity,
            height: null,
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
