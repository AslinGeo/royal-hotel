import 'package:get/get.dart';
import 'package:royal_hotel/pages/login/login.controller.dart';
import 'package:royal_hotel/pages/register/register.controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => LoginController());
  }
}
