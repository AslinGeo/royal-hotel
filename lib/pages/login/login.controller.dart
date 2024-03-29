import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/pages/common/common.view.dart';
import 'package:royal_hotel/pages/home/home.controller.dart';
import 'package:royal_hotel/pages/login/login.variable.dart';
import 'package:royal_hotel/route/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with LoginVariable {
  init() {}

  login() async {
    var validEmail = validateEmail(emailController.text);
    var validPass = validatePassword(passwordController.text);
    if (validEmail == null && validPass == null) {
      try {
        UserCredential user = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        SharedPreferences sharedPreferences = await prefs;
        if (user.user!.uid == "W35mmz4XCISs000KXGRQ5uAj6At2") {
          sharedPreferences.setBool("isAdmin", true);
        } else {
          sharedPreferences.setBool("isAdmin", false);
        }
        DatabaseReference reference = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(user.user!.uid);
        var data = await reference.once();
        reference.onValue.listen((event) {
          DataSnapshot dataSnapshot = event.snapshot;

          Map<dynamic, dynamic> values =
              dataSnapshot.value as Map<dynamic, dynamic>;
          values.forEach((key, values) {
            sharedPreferences.setString(key, values);
          });
        });

        Get.offAllNamed(AppPaths.home);
      } catch (e) {
        commonWidgets().snackbar("", e.toString());
        print('An unexpected error occurred: $e');
        // Handle other unexpected errors.
      }
    } else {
      Get.snackbar("", validEmail ?? validPass);
    }
  }

  validatePassword(String value) {
    // Basic password validation - at least 6 characters
    if (value.length < 6) {
      return "passwordErrorMsg".tr;
    }
    return null;
  }

  validateEmail(String value) {
    // Basic email validation using a regex pattern
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return "emailErrorMsg".tr;
    }
    return null;
  }
}
