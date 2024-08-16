import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_pro/modules/screens/chat-app/view/chat-app.dart';
import 'package:talk_pro/modules/screens/chat-details/view/chat-detal.dart';
import 'package:talk_pro/modules/screens/home-screen/view/home-screen.dart';
import 'package:talk_pro/modules/screens/login-screen/view/login-screen.dart';
import 'package:talk_pro/modules/screens/one-time-intro/view/one-time-intro.dart';
import 'package:talk_pro/modules/screens/user-shows/view/user-show.dart';
import 'package:talk_pro/utils/color.dart';

import 'firebase_options.dart';
import 'modules/screens/sign-up-screen/views/sign-up-screen.dart';
import 'modules/screens/splash-screen/view/spalsh-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: 'AIzaSyAS93QxE9LEHMevjlRZJLbu6UReK5BOC_4');
  runApp(
    GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: primaryColor,
          textTheme: GoogleFonts.openSansTextTheme()),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
          primaryColor: Colors.white, scaffoldBackgroundColor: Colors.black),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/intro',
          page: () => IntroScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: '/userShow',
          page: () => const UserShow(),
        ),
        GetPage(
          name: '/chat',
          page: () => const ChatScreen(),
        ),
        GetPage(
          name: '/chat-detail',
          page: () => const ChatDetail(),
        ),
      ],
    ),
  );
}
