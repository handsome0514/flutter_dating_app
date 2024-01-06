import 'package:bematched/screens/splash_screen/splash_screen.dart';
import 'package:bematched/utils/constants.dart';
import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeMatched',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        defaultTransition: Transition.native,
        locale: const Locale('en', 'US'),
        translations: AppLanguage(),
        builder: EasyLoading.init(),
        home: SplashScreen(),
      ),
    );
  }
}
