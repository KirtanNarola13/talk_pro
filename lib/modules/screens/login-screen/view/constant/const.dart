import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/modules/screens/login-screen/model/sign-up-model.dart';
import 'package:talk_pro/modules/screens/login-screen/view/constant/string.dart';

import '../../../../../utils/auth-helper.dart';

anonymous() async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInAnonymous();
  if (res['error'] != null) {
    log("login failed");
  } else {
    log("login success");
    Get.toNamed('/home');
  }
}

signUp({required String email, required String password}) async {
  SignUpModel signUpModel =
      SignUpModel(email: email ?? "", password: password ?? "");
  Map<String, dynamic> res =
      await AuthHelper.authHelper.signUp(signUpModel: signUpModel);
  if (res['error'] != null) {
    log('signup failed');
  } else {
    log('user created');
  }
}

Stack loginStack() => Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: (Get.isDarkMode == true) ? Colors.white : Colors.black,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          color: (Get.isDarkMode == true) ? Colors.black : Colors.white,
          child: const Text("OR"),
        ),
      ],
    );

Container loginContainer(
        {required String img, required BuildContext context}) =>
    Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.sizeOf(context).height / 15,
      width: MediaQuery.sizeOf(context).height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (Get.isDarkMode == true)
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
      ),
      child: Image.asset(img),
    );
