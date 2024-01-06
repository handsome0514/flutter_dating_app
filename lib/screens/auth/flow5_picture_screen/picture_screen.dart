import 'dart:io';
import 'package:bematched/config.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/custom_button.dart';

import 'picture_screen_controller.dart';

class PictureScreen extends StatelessWidget {
  PictureScreen({super.key, this.isBack});

  final bool? isBack;

  final _controller = Get.put(PictureScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              LinearProgressIndicator(
                backgroundColor: const Color(0xFFD9D9D9),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
                value: 0.625,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add 2 or more pictures',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Obx(
                () => Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '${_controller.pathList.length}/15',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Obx(
                () => Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(0),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: (1 / .7),
                    children: <Widget>[
                      ...List.generate(
                        _controller.pathList.length,
                        (index) => Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE1E1E1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                    image: FileImage(
                                      File(_controller.pathList[index]),
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: GestureDetector(
                                onTap: () => _controller.deSelectItem(index),
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.BLACK,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!(_controller.pathList.length >= 15))
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _controller.picker,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFE1E1E1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  Text(
                                    "Add Photo",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '5 / 8',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (isBack ?? false)
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            borderRadius: BorderRadius.circular(50),
                            buttonLabel: 'Back',
                            onTap: Get.back,
                            borderColor: AppColors.themeColor,
                            buttonColor: AppColors.whiteColor,
                            textColor: AppColors.themeColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            borderRadius: BorderRadius.circular(50),
                            buttonLabel: 'Next',
                            onTap: _controller.setImages,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      borderRadius: BorderRadius.circular(50),
                      buttonLabel: 'Next',
                      onTap: _controller.setImages,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
