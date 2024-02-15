import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talk_pro/utils/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        logo: 'lib/assets/app-icon.png',
        title: 'TALK PRO',
        theme: LoginTheme(
          titleStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: subBackground,
                offset: Offset(-0.5, -3),
              ),
            ],
            letterSpacing: 3,
            color: primaryTextColor,
          ),
          primaryColor: subBackground.withOpacity(0.5),
          cardTheme: CardTheme(
            shadowColor: primaryTextColor,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
          ),
          buttonTheme: LoginButtonTheme(
            elevation: 5,
            backgroundColor: primaryTextColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            splashColor: background,
          ),
        ),
        loginAfterSignUp: true,
        onSignup: (_) {},
        loginProviders: [
          LoginProvider(callback: () {}, icon: FontAwesomeIcons.google),
          LoginProvider(callback: () {}, icon: FontAwesomeIcons.phone),
        ],
        onLogin: (_) {},
        onRecoverPassword: (_) {},
      ),
    );
  }
}
