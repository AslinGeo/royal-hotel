import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin HomeVariables {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String userName = "";
  String userEmail = "";
  RxList adminList = [
    {"name": "menu".tr, "key": "Menu"},
    {"name": "inventory".tr, "key": "Inventory"},
    {"name": "orders".tr, "key": "Orders"},
  ].obs;
  RxList chefList = [
    {"name": "newOrders".tr, "key": "New Orders"},
    {"name": "assignedOrders".tr, "key": "Assigned Orders"},
    {"name": "completedOrders".tr, "key": "Completed Orders"},
  ].obs;
  RxBool isAdmin = false.obs;
  RxInt selectedIndex = 0.obs;
  RxList menus = [].obs;
  RxList orders = [].obs;
  RxList inventorys = [].obs;
  RxList userList = [].obs;
  RxList chefOrders = [].obs;
  RxList chefAssignedOrders = [].obs;
  RxList chefCompletedOrders = [].obs;
}
