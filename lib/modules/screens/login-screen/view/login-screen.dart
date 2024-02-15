import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:talk_pro/utils/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        logo: const AssetImage('lib/assets/app-icon.png'),
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
          bodyStyle: TextStyle(color: primaryColor),
          inputTheme:
              InputDecorationTheme(labelStyle: TextStyle(color: subTextColor)),
          textFieldStyle: TextStyle(
            color: primaryTextColor,
          ),
          primaryColor: background,
          cardTheme: CardTheme(
            shadowColor: subBackground,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
          ),
          primaryColorAsInputLabel: true,
          cardInitialHeight: 200,
          buttonTheme: LoginButtonTheme(
            elevation: 5,
            backgroundColor: subBackground,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            splashColor: background,
          ),
          errorColor: primaryTextColor,
        ),
        hideForgotPasswordButton: true,
        validateUserImmediately: true,
        loginAfterSignUp: true,
        onLogin: (val) {},
        onRecoverPassword: (val) {},
        onSignup: (val) {},
      ),
    );
  }
}
