// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_pro/modules/screens/login-screen/model/sign-up-model.dart';

import '../../../../../utils/auth-helper.dart';

//todo: anonymous btn click
anonymous() async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInAnonymous();
  if (res['error'] != null) {
    log("login failed");
  } else {
    log("login success");
    Get.toNamed('/home');
  }
}

//todo: signup btn click
signUp({required String email, required String password}) async {
  SignUpModel signUpModel = SignUpModel(email: email, password: password);
  Map<String, dynamic> res =
      await AuthHelper.authHelper.signUp(signUpModel: signUpModel);
  if (res['error'] != null) {
    log('signup failed');
  } else {
    log('user created');
  }
}

//todo: login btn click
login(
    {required String email,
    required String password,
    required BuildContext context}) async {
  SignUpModel signUpModel = SignUpModel(email: email, password: password);
  Map<String, dynamic> res =
      await AuthHelper.authHelper.login(signUpModel: signUpModel);
  if (res['error'] != null) {
    return CherryToast.error(
      title: const Text("Login Failed"),
    ).show(context);
  } else {
    return CherryToast.success(title: const Text("Login Success"))
        .show(context);
  }
}

google({required BuildContext context}) async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInWithGoogle();
  if (res['error'] != null) {
    return CherryToast.error(title: const Text("Login Failed")).show(context);
  } else {
    return CherryToast.success(
        title: const Text(
      "Login Success",
    )).show(context);
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
