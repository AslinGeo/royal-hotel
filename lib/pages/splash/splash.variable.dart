import 'package:get/get.dart';

mixin SplashVariable {
  RxList languages = [
    {"name": "English", "key": "en"},
    {"name": "Japanese", "key": "ja"},
    {"name": "Spanish", "key": "es"},
    {"name": "Hindi", "key": "hi"},
    {"name": "German", "key": "de"},
    {"name": "Portuguese", "key": "pt"},
  ].obs;
  RxString selectedLanguage = "English".obs;
}
