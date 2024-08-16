import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/modules/screens/home-screen/view/home-screen.dart';
import 'package:talk_pro/utils/auth-helper.dart';
import 'package:talk_pro/utils/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      AuthHelper.auth.currentUser == null
          ? Get.offAndToNamed('/intro')
          : Get.to(HomeScreen());
    });
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: background.withOpacity(0.5),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 10,
                child: Image(
                  image: AssetImage('lib/assets/app-icon.png'),
                ),
              ),
              Expanded(
                child: Text(
                  "TALK PRO",
                  style: TextStyle(
                    fontSize: 32,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 5,
                    color: primaryTextColor,
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
