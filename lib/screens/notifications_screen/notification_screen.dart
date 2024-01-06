import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: Get.back,
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.BLACK,
            )),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFonts.INTER_MEDIUM,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 26),
              ...List.generate(10, (index) => const NotificationCard()),
            ],
          ),
        ),
      ),
    );
  }
}
