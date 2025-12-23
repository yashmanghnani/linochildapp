import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lino/src/view/dashboard/home_screen.dart';
import 'package:lino/src/view/dashboard/lets_talk_Screen.dart';
import 'package:lino/src/view/onboarding/create_Account_Parents_Screen.dart';
import 'package:lino/src/view/onboarding/create_account_kids_screen.dart';
import 'package:lino/src/view/onboarding/login_Screen.dart';
import 'package:lino/src/view/onboarding/splash_Screen.dart';
import 'package:lino/src/view/widgets/app_Audio_Service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await AppAudioService().startBackgroundSound();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: SplashScreen(),
      initialRoute: '/',
      routes: {
        "/": (context) => SplashScreen(),
        "/Home": (context) => HomeScreen(),
        "/letsTalk": (context) => LetsTalkScreen(),
        "/login": (context) => LoginScreen(),

        "/createaccountParent": (context) => CreateAccountScreen(),
        "/createaccountkid": (context) => CreateAccountKidsScreen(),
      },
    );
  }
}
