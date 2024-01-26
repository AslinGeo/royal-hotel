import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/pages/common/common.view.dart';
import 'package:royal_hotel/pages/register/register.variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController with RegisterVariables {
  registerAccount() async {
    var validName = validateName(nameController.text);
    var validEmail = loginController.validateEmail(emailController.text);
    var validPass = loginController.validatePassword(passwordController.text);
    if (validEmail == null && validPass == null && validName == null) {
      try {
        UserCredential user = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        User? userData = FirebaseAuth.instance.currentUser;

        if (userData != null) {
          isRegistrationSuccess.value = true;
          SharedPreferences sharedPreferences = await prefs;
          sharedPreferences.setString("name", nameController.text);
          sharedPreferences.setString("email", emailController.text);
          await database.child('users').child(user.user!.uid).set({
            'username': nameController.text,
            'email': emailController.text,
            "uid": userData.uid
          });
        }
      } catch (e) {
        return e;
      }
    } else {
      commonWidgets().snackbar("", validName ?? (validEmail ?? validPass));
    }
  }

  validateName(value) {
    value.toString().trim();
    if (value == null || value.isEmpty) {
      return "nameErrorMsg".tr;
    } else {
      return null;
    }
  }
}
