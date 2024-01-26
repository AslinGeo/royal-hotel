import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/appasstes.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/constant/appfonts.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/pages/login/login.view.dart';
import 'package:royal_hotel/pages/register/register.controller.dart';
import 'package:royal_hotel/route/path.dart';
import 'package:royal_hotel/route/route.dart';

class RegisterView extends GetResponsiveView<RegisterController> {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.lightGreen02,
      body: Obx(() =>
          controller.isRegistrationSuccess.value ? successBody() : body()),
    ));
  }

  body() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.loginLogo,
                  height: 300,
                  width: 300,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.lightGreen,
                    ),
                    hintText: "email".tr,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // LoginView().buildErrorText(controller.loginController
            //     .validateEmail(controller.emailController.text)),
            const SizedBox(
              height: 10,
            ),

            // Password Input Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.lightGreen,
                    ),
                    hintText: "userName".tr,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            // LoginView().buildErrorText(
            //     controller.validateName(controller.nameController.text)),

            const SizedBox(
              height: 10,
            ),

            // Password Input Field
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.lightGreen,
                    ),
                    hintText: "password".tr,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // LoginView().buildErrorText(controller.loginController
            //     .validatePassword(controller.passwordController.text)),
            const SizedBox(
              height: 10,
            ),
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                controller.registerAccount();
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
                      "register".tr,
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

  successBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.registrationSuccess,
                height: 300,
                width: 300,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "registration".tr,
            style: AppFonts().h1.copyWith(color: AppColors.black),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "complete".tr,
            style: AppFonts().h1.copyWith(color: AppColors.black),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppPaths.home);
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
                    "textContinue".tr,
                    style: AppFonts().h2.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
