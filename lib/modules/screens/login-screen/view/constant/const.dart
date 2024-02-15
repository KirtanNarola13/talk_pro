import '../../../../../utils/auth-helper.dart';

anonymous() async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInAnonymous();
  if (res['error'] != null) {
  } else {
    log("login success");
  }
  return res;
}
