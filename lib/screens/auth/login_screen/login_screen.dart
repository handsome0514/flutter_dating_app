import 'package:bematched/config.dart';
import 'package:bematched/screens/auth/login_screen/login_screen_controller.dart';
import 'package:bematched/screens/auth/phone_screen/phone_screen.dart';
import 'package:bematched/utils/constants.dart';
import 'package:bematched/widgets/custom_button.dart';
import 'package:bematched/widgets/custom_textfield.dart';
import 'package:bematched/widgets/singlechild_spacer_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildSpacerWidget(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(ImageAssets.logo),
                ),
                const SizedBox(height: 36),
                const Text(
                  'Hello, Welcome back to your account',
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: AppFonts.INTER_SEMIBOLD,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 23),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintLabel: 'Enter your Email',
                  onChanged: (val) => _controller.email = val,
                ),
                const SizedBox(height: 23),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: AppFonts.INTER_MEDIUM,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintLabel: 'Enter your Password',
                  onChanged: (val) => _controller.password = val,
                  isPassword: true,
                ),
                const SizedBox(height: 31),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffEB4585),
                            const Color(0xffFA8792).withOpacity(.25),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                    )),
                    const SizedBox(width: 8),
                    const Text(
                      'Or Login With',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.INTER_REGULAR,
                          color: Color(0xff555252)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffEB4585),
                            const Color(0xffFA8792).withOpacity(.25),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 31),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Get.to(() => PhoneScreen()),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 19, bottom: 19),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff1877F2)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: Get.width * 0.20),
                        const Icon(Icons.phone),
                        const SizedBox(width: 16),
                        const Text(
                          'Sign up with Phone',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 13),
/*                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _controller.loginWithFacebook,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 19, bottom: 19),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff1877F2)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: Get.width * 0.20),
                        SvgPicture.asset(SvgAssets.FACEBOOK_ICON),
                        const SizedBox(width: 16),
                        const Text(
                          'Sign up with Facebook',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                /*    const SizedBox(height: 13),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _controller.loginWIthGoogle,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 19, bottom: 19),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffF1574A)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: Get.width * 0.20),
                        SvgPicture.asset(SvgAssets.GOOGLE_ICON),
                        const SizedBox(width: 16),
                        const Text(
                          'Sign up with Gmail',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: AppFonts.INTER_MEDIUM,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                const SizedBox(height: 55),
                const Spacer(),
                CustomButton(
                  buttonLabel: AppLanguage.LOGIN,
                  onTap: _controller.loginIntoTheApp,
                ),
                const SizedBox(height: 29),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
