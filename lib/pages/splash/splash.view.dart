import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:royal_hotel/constant/appasstes.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/constant/appfonts.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/pages/splash/splash.controller.dart';
import 'package:royal_hotel/route/path.dart';

class SplashView extends GetResponsiveView<SplashController> {
  SplashView({super.key}) {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.splashLogo,
              height: 300,
              width: 300,
            ),
          ],
        ),
        Text(
          AppStrings.foodienator,
          style: AppFonts().h1.copyWith(color: AppColors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppStrings.splashMessage,
          style: AppFonts().h3.copyWith(color: AppColors.white),
        ),
        bottomButton(),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            languageBottomsheet(Get.context);
          },
          child: Container(
            width: 300,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text(AppStrings.register,
                    style: AppFonts().h3Bold.copyWith(color: AppColors.black)),
              ),
            ),
          ),
        )
      ],
    );
  }

  bottomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppPaths.login);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightGreen02,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Text(AppStrings.signin,
                          style: AppFonts()
                              .h3Bold
                              .copyWith(color: AppColors.white)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppPaths.register);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Text(AppStrings.register,
                          style: AppFonts()
                              .h3Bold
                              .copyWith(color: AppColors.black)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  languageBottomsheet(context) {
    return showModalBottomSheet(
        backgroundColor: AppColors.white,
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => SizedBox(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Select Language"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  ...controller.languages.map((element) {
                    return InkWell(
                      onTap: () {
                        Get.updateLocale(Locale(element["key"]));
                        Get.back();
                      },
                      child: Column(
                        children: [
                          Text(element["name"]),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  }).toList()
                ],
              ),
            ));
  }
}
