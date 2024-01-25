import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:royal_hotel/pages/home/home.bindings.dart';
import 'package:royal_hotel/pages/home/home.view.dart';
import 'package:royal_hotel/pages/login/login.binding.dart';
import 'package:royal_hotel/pages/login/login.view.dart';
import 'package:royal_hotel/pages/register/register.bindings.dart';
import 'package:royal_hotel/pages/register/register.view.dart';
import 'package:royal_hotel/pages/splash/splash.binding.dart';
import 'package:royal_hotel/pages/splash/splash.view.dart';
import 'package:royal_hotel/route/path.dart';

class AppPages {
  AppPages._();
  static const inital = AppPaths.splash;
  static final route = [
    GetPage(
        name: AppPaths.splash,
        binding: SplashBindings(),
        page: () => SplashView()),
    GetPage(
        name: AppPaths.login, binding: LoginBinding(), page: () => LoginView()),
    GetPage(
        name: AppPaths.register,
        binding: RegisterBindings(),
        page: () => RegisterView()),
    GetPage(
        name: AppPaths.home, binding: HomeBindings(), page: () => HomeView()),
  ];
}
