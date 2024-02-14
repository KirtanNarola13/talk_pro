import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:talk_pro/utils/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlutterLogin(
        logo: const AssetImage('lib/assets/app-icon.png'),
        title: 'TALK PRO',
        theme: LoginTheme(
          titleStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: primaryColor),
          bodyStyle: TextStyle(color: primaryColor),
          primaryColor: primaryColor.withOpacity(0.5),
          cardTheme: CardTheme(
            shadowColor: primaryColor,
          ),
          buttonTheme: LoginButtonTheme(
            elevation: 5,
            highlightColor: Colors.white,
            backgroundColor: primaryColor,
          ),
          errorColor: Colors.black,
        ),
        onLogin: (val) {},
        onRecoverPassword: (val) {},
        onSignup: (val) {},
      ),
    );
  }
}
