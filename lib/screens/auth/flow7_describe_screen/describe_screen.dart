import 'package:bematched/config.dart';
import 'package:bematched/widgets/singlechild_spacer_widget.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/custom_button.dart';
import 'describe_screen_controller.dart';

class DescribeScreen extends StatelessWidget {
  DescribeScreen({super.key, this.isBack});

  final bool? isBack;

  final _controller = Get.put(DescribeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildSpacerWidget(
            child: Column(
              children: [
                const SizedBox(height: 25),
                LinearProgressIndicator(
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.black,
                  ),
                  value: 0.875,
                  borderRadius: BorderRadius.circular(20),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Describe yourself in a few\nwords',
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
                TextFormField(
                  minLines: 8,
                  maxLines: null,
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: Colors.black),
                  onChanged: (val) => _controller.description = val,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 13, top: 20, bottom: 20, right: 13),
                    hintText: 'Enter your answer',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: AppFonts.INTER_REGULAR,
                      color: Colors.black.withOpacity(.40),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '7 / 8',
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
                              onTap: _controller.setDescription,
                            ),
                          ),
                        ],
                      )
                    else
                      CustomButton(
                        borderRadius: BorderRadius.circular(50),
                        buttonLabel: 'Next',
                        onTap: _controller.setDescription,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
