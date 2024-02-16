import 'package:firebase_auth/firebase_auth.dart';
import 'package:talk_pro/modules/screens/login-screen/model/sign-up-model.dart';
import 'package:talk_pro/modules/screens/login-screen/view/constant/string.dart';

class AuthHelper {
  AuthHelper._();

  //todo:var
  static final AuthHelper authHelper = AuthHelper._();
  static FirebaseAuth auth = FirebaseAuth.instance;

  //todo: Anonymous login
  Future<Map<String, dynamic>> signInAnonymous() async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  //todo: SignUP With Email Pass
  Future<Map<String, dynamic>> signUp(
      {required SignUpModel signUpModel}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: signUpModel.email, password: signUpModel.password);
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }
}
