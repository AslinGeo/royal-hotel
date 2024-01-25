import 'package:get/get.dart';
import 'package:royal_hotel/pages/login/login.controller.dart';


class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}