import 'dart:developer';

class Validation {
  static bool checkValidation(String email, String password) {
    if (email == "" && password == "") {
      log("Enter right credential!...");
      return false;
    } else {
      // call method
      return true;
    }
  }
}
