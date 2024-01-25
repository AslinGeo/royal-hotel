import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/appasstes.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/constant/appfonts.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/pages/login/login.controller.dart';

class LoginView extends GetResponsiveView<LoginController> {
  LoginView({super.key}) {
    controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGreen,
        body: body(),
      ),
    );
  }

  body() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.man,
                  height: 250,
                  width: 300,
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.welcomeText,
              style: AppFonts().h1.copyWith(color: AppColors.black),
            ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  validator: (value) {
                    return controller.validateEmail(value.toString());
                  },
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.lightGreen,
                    ),
                    hintText: AppStrings.email,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // buildErrorText(
            //     controller.validateEmail(controller.emailController.text)),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  validator: (value) {
                    controller.validatePassword(value.toString());
                  },
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.lightGreen,
                    ),
                    hintText: AppStrings.password,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // buildErrorText(controller
            //     .validatePassword(controller.passwordController.text)),
            const SizedBox(
              height: 10,
            ),
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                controller.login();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.lightOrange04),
                  elevation: MaterialStateProperty.all<double>(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ))),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.login,
                      style: AppFonts().h2.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            )
            // Recovery Password Icon
          ],
        ),
      ),
    );
  }

  Widget buildErrorText(error) {
    return error != null
        ? Text(
            error,
            style: const TextStyle(color: Colors.red),
          )
        : const SizedBox.shrink();
  }
}
