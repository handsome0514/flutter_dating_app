import 'package:bematched/widgets/custom_dailogs.dart';
import 'package:bematched/widgets/singlechild_spacer_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import 'help_screen_controller.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({Key? key}) : super(key: key);

  final HelpScreenController _controller = Get.put(HelpScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: Get.back,
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.themeColor,
            size: 20,
          ),
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildSpacerWidget(
          child: Column(
            children: [
              const SizedBox(height: 37),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: AppColors.BLACK,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 46,
                width: double.infinity,
                child: TextFormField(
                  controller: _controller.titleController,
                  decoration: InputDecoration(
                    hintText: 'Input Title Here',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: AppColors.GREY,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.BLACK),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.BLACK),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.BLACK),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Your Question',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: AppColors.BLACK,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  maxLines: 7,
                  controller: _controller.questionController,
                  decoration: InputDecoration(
                    hintText: 'Question Input Here',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: AppColors.GREY,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.BLACK),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.BLACK),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.BLACK),
                    ),
                  ),
                ),
              ),
              /*  const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.themeColor,
                ),
                child: const Text(
                  AppLanguage.HELP_DESCRIPTION,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.SF_PRO_ROUNDED_Regular,
                    color: Color(0xff9C9798),
                  ),
                ),
              ),*/
              Spacer(),
              SizedBox(height: Get.height * 0.18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: Get.back,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 17, bottom: 17, left: 47, right: 47),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.WHITE,
                          border: Border.all(
                            color: AppColors.themeColor,
                          )),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_MEDIUM,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_controller.titleController.value.text.isEmpty ||
                          _controller.questionController.value.text.isEmpty)return;
                      try {
                        final email = Email(
                          subject: _controller.titleController.text,
                          body: _controller.questionController.text,
                          recipients: ['beMatched@gmail.com'],
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(email);
                        await CustomDailogs.okSuccessAlertDialog(context,
                            'Your Question has been Submit Successfully');
                        _controller.titleController.clear();
                        _controller.questionController.clear();
                      } catch (e) {
                        if (kDebugMode) print(e);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 17, bottom: 17, left: 47, right: 47),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.themeColor,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
