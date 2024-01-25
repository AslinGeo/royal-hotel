import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/pages/login/login.controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin RegisterVariables {
  RxBool isRegistrationSuccess = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  LoginController loginController = Get.find();
  final DatabaseReference database = FirebaseDatabase.instance.ref();
   final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
}
