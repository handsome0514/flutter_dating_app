import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.DARK_BLUE,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Resources',
          style: TextStyle(
            fontSize: 16,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.DARK_BLUE,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 62),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GREY.withOpacity(.5)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 19, bottom: 19),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: AppColors.DARK_BLUE,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GREY.withOpacity(.5)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 19, bottom: 19),
                  child: Text(
                    'Term of Service',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: AppColors.DARK_BLUE,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GREY.withOpacity(.5)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 19, bottom: 19),
                  child: Text(
                    'License',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: AppColors.DARK_BLUE,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
