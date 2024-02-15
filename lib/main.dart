import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_pro/modules/screens/login-screen/view/login-screen.dart';
import 'package:talk_pro/utils/color.dart';

import 'firebase_options.dart';
import 'modules/screens/splash-screen/view/spalsh-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: primaryColor,
          textTheme: GoogleFonts.openSansTextTheme()),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen()!,
        ),
      ],
    ),
  );
}
