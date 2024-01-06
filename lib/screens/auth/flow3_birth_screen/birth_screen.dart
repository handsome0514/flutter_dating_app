import 'package:bematched/config.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/utils/extension.dart';
import 'package:bematched/widgets/calender_bottomsheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../widgets/custom_button.dart';

import 'birth_screen_controller.dart';

class BirthScreen extends StatelessWidget {
  BirthScreen({super.key, this.isBack});

  final bool? isBack;

  final _controller = Get.put(BirthScreenController());

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
                value: 0.5,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What is your Birthday?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 25),
              GetBuilder<BirthScreenController>(
                builder: (controller) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    var date = await Get.bottomSheet(
                      CalenderBottomSheet(),
                      isScrollControlled: true,
                      persistent: false,
                    );
                    print('Date>>>$date');
                    if (date != null) {
                      _controller.selectedDate = date;
                      print('Date>>>${_controller.selectedDate}');
                      _controller.update();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 19, bottom: 19, left: 13, right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffD9D9D9)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _controller.selectedDate != null
                              ? _controller.selectedDate!.dd_mm_yyyy
                              : 'Enter your date of birth',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: AppFonts.INTER_REGULAR,
                          ),
                        ),
                        SvgPicture.asset(SvgAssets.CALENDER_ICON),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '3 / 8',
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
                            onTap: _controller.setDOB,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      borderRadius: BorderRadius.circular(50),
                      buttonLabel: 'Next',
                      onTap: _controller.setDOB,
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
