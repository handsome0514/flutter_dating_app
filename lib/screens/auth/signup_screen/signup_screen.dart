import 'package:bematched/config.dart';
import 'package:bematched/screens/auth/signup_screen/signup_screen_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/singlechild_spacer_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _controller = Get.put(SignUpScreenController());

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
                  'Hello, Welcome to beMatch',
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 55),
                const Spacer(),
                CustomButton(
                  buttonLabel: 'Sign Up',
                  onTap: _controller.signUp,
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
