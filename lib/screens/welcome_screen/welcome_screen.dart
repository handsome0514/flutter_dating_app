import 'package:bematched/config.dart';
import 'package:bematched/screens/auth/login_screen/login_screen.dart';
import 'package:bematched/screens/auth/signup_screen/signup_screen.dart';
import 'package:bematched/widgets/custom_button.dart';
import '../../utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 13),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.homeBG),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                AppLanguage.welcomeTo,
                style: GoogleFonts.acme(
                  fontSize: 55,
                  color: AppColors.whiteColor,
                ),
              ),
              Center(child: Image.asset(ImageAssets.logo)),
              const SizedBox(height: 22),
              const Text(
                AppLanguage.welcomeToDescription,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffF1F1F1),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              CustomButton(
                buttonLabel: AppLanguage.start,
                onTap: () => Get.to(() => SignUpScreen()),
              ),
              const SizedBox(height: 11),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  AppLanguage.LOGIN,
                  style: GoogleFonts.abhayaLibre(
                    textStyle: const TextStyle(
                      fontSize: 23,
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
