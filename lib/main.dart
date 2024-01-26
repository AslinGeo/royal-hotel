import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/firebase_options.dart';
import 'package:royal_hotel/route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: AppColors.lightGreen, // navigation bar color
    statusBarColor: AppColors.lightGreen,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      title: 'Royal Hotel',
      theme: ThemeData(),
      initialRoute: AppPages.inital,
      getPages: AppPages.route,
      debugShowCheckedModeBanner: false,
    );
  }
}
