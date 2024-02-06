import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProviders with ChangeNotifier {
  void signUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        log("User Created!...");
        if (context.mounted) Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
    notifyListeners();
  }

  Future<UserCredential?> login(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        log("Log In Success fully!...");
      }
    } on FirebaseAuthException catch (error) {
      log(error.code.toString());
    }
    notifyListeners();
    return userCredential;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    log("Sign out success.....");
  }
}
