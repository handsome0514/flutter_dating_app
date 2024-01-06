import 'package:bematched/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../utils/app_cache_image.dart';
import '../../widgets/custom_back_button.dart';
import 'gallery_screen_controller.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({
    super.key,
    required this.userModel,
    required this.isMyProfile,
  });

  final _controller = Get.put(GalleryScreenController());
  final UserModel userModel;
  final bool isMyProfile;

  @override
  Widget build(BuildContext context) {
    _controller.userModel.value = userModel;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(children: [
                const CustomBackButton(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                          fontFamily: AppFonts.INTER_BOLD,
                          fontSize: 16,
                          color: AppColors.BLACK,
                        ),
                      )),
                ),
                if (isMyProfile)
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _controller.showImagePicker(),
                          child: const Text(
                            'Add Photos',
                            style: TextStyle(
                              fontFamily: AppFonts.INTER_BOLD,
                              fontSize: 14,
                              color: AppColors.BLACK,
                            ),
                          ),
                        )),
                  )
              ]),
            ),
            Expanded(child: GetBuilder<GalleryScreenController>(
              builder: (controller) {
                return ListView(
                  children: [
                    ...?_controller.userModel.value.images
                        ?.map((e) => e.toString())
                        .map((element) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            AppCacheImage(
                                round: 0,
                                imageUrl: element,
                                boxFit: BoxFit.fitWidth,
                                width: double.infinity,
                                height: null),
                            if (isMyProfile)
                              Container(
                                width: 40,
                                height: 40,
                                margin:
                                    const EdgeInsets.only(top: 15, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.DARK_BLUE,
                                ),
                                child: MaterialButton(
                                  onPressed: () =>
                                      _controller.deleteImages(element),
                                  padding: EdgeInsets.zero,
                                  minWidth: 40,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )),
                                ),
                              )
                          ],
                        ),
                      );
                    })
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
