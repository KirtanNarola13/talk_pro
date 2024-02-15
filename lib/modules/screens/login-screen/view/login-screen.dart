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
              color: appColor),
          bodyStyle: TextStyle(color: appColor),
          primaryColor: appColor.withOpacity(0.5),
          cardTheme: CardTheme(
            shadowColor: appColor,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(100.0)),
          ),
          primaryColorAsInputLabel: true,
          cardInitialHeight: 200,
          buttonTheme: LoginButtonTheme(
            elevation: 5,
            backgroundColor: primaryColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            splashColor: appColor,
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
