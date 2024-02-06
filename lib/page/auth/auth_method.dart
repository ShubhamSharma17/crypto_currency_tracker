class AuthMethods {
  // static void signUp(
  //     String email, String password, BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     if (userCredential.user != null) {
  //       log("User Created!...");
  //       if (context.mounted) Navigator.of(context).pop();
  //     }
  //   } on FirebaseAuthException catch (ex) {
  //     log(ex.code.toString());
  //   }
  // }

  // static Future<UserCredential?> login(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     if (userCredential.user != null) {
  //       log("Log In Success fully!...");
  //       return userCredential;
  //     }
  //   } on FirebaseAuthException catch (error) {
  //     log(error.code.toString());
  //   }
  //   return null;
  // }
}
