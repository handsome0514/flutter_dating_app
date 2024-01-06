import 'package:bematched/config.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/custom_button.dart';
import 'interest_screen_controller.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({super.key, this.isBack});

  final bool? isBack;
  final _controller = Get.put(InterestScreenController());

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
                value: 0.75,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    'Your Interests',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Obx(() => Text(
                        '${_controller.selectedInterests.length}/5',
                        style: GoogleFonts.playfairDisplay(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
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
                    childAspectRatio: (1 / .3),
                    children: List.generate(
                      interests.length,
                      (i) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _controller.selector(i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: _controller.selectedInterests.contains(i)
                                ? AppColors.themeColor
                                : Colors.white,
                            border: Border.all(color: const Color(0xFFD9D9D9)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                interests[i]["icon"],
                                color: _controller.selectedInterests.contains(i)
                                    ? AppColors.whiteColor
                                    : AppColors.themeColor,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                interests[i]["text"],
                                style: _controller.selectedInterests.contains(i)
                                    ? const TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFonts.INTER_BOLD,
                                        color: AppColors.whiteColor,
                                      )
                                    : const TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFonts.INTER_REGULAR,
                                        color: AppColors.BLACK,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '6 / 8',
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
                            onTap: _controller.setInterest,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      borderRadius: BorderRadius.circular(50),
                      buttonLabel: 'Next',
                      onTap: _controller.setInterest,
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
