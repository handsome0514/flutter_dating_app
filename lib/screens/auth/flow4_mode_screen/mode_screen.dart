import '../../../config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/gender_selection.dart';
import 'mode_screen_controller.dart';

class ModeScreen extends StatelessWidget {
  ModeScreen({super.key, this.isBack=false});

  final bool isBack;


  final _controller = Get.put(ModeScreenController());

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
                value: 0.375,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose your option',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 35),
              Obx(
                () => Column(
                  children: List.generate(
                    _controller.modeList.length,
                    (index) => GenderSelection(
                      onTap: () => _controller.selectedMode.value = index,
                      isSelected: _controller.selectedMode.value == index,
                      label: _controller.modeList[index],
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
                    '4 / 8',
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
                            onTap: _controller.setMode,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      borderRadius: BorderRadius.circular(50),
                      buttonLabel: 'Next',
                      onTap: _controller.setMode,
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
