import 'package:get/get.dart';
import 'package:royal_hotel/pages/splash/splash.controller.dart';


class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
