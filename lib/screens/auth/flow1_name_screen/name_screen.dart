import 'package:bematched/screens/auth/flow1_name_screen/name_screen_controller.dart';
import 'package:bematched/widgets/custom_button.dart';
import 'package:bematched/widgets/custom_textfield.dart';
import 'package:bematched/config.dart';

import '../../../../utils/constants.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key, this.isBack});

  final bool? isBack;

  final _controller = Get.put(NameScreenController());

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
                value: 0.125,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What is your name?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 25),
              CustomTextField(
                hintLabel: 'Enter your name',
                onChanged: (val) => _controller.name = val,
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '1 / 8',
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
                            onTap: _controller.setName,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomButton(
                      borderRadius: BorderRadius.circular(50),
                      buttonLabel: 'Next',
                      onTap: _controller.setName,
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
