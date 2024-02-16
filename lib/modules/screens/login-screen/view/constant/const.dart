import 'dart:developer';

import 'package:talk_pro/modules/screens/login-screen/model/sign-up-model.dart';
import 'package:talk_pro/modules/screens/login-screen/view/constant/string.dart';

import '../../../../../utils/auth-helper.dart';

Future<String?>? anonymous() async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInAnonymous();
  if (res['error'] != null) {
    log("login failed");
  } else {
    log("login success");
  }
  return null;
}

signUp() async {
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
