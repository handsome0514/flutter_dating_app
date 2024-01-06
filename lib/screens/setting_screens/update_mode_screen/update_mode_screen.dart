import 'package:bematched/screens/setting_screens/update_mode_screen/upate_mode_screen_controller.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/connection_box.dart';
import '../../admin_base_controller.dart';
import '../../home_screen/home_screen_controller.dart';
import 'update_connection_box.dart';

class UpdateModeScreen extends StatelessWidget {
  UpdateModeScreen({super.key});

  final controller = Get.put(UpdateModeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Choose Mode',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFonts.INTER_SEMIBOLD,
            color: AppColors.BLACK,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            ...List.generate(
              connectionList.length,
              (index) {
                if ((controller.userModel.isDate ?? true) == false) {
                  print('index=>>>$index==>>>${controller.userModel.isDate}');
                  if (index == 0) return const SizedBox.shrink();
                }
                return Obx(
                  () => UpdateConnectionBox(
                    isSelected: controller.selectedIndex.value == index,
                    title: connectionList[index]['title'],
                    description: connectionList[index]['des'],
                    onTap: () {
                      controller.selectedIndex.value = index;
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 37),
            GestureDetector(
              onTap: controller.updateMode,
              child: Container(
                padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.themeColor,
                ),
                child: const Center(
                  child: Text(
                    'Choose',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.INTER_MEDIUM,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
