import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin HomeVariables {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String userName = "";
  String userEmail = "";
  RxList adminList = [
    {"name": AppStrings.menu, "key": "Menu"},
    {"name": AppStrings.inventory, "key": "Inventory"},
    {"name": AppStrings.orders, "key": "Orders"},
  ].obs;
  RxList chefList = [
    {"name": AppStrings.newOrders, "key": "New Orders"},
    {"name": AppStrings.assignedOrders, "key": "Assigned Orders"},
    {"name": AppStrings.completedOrders, "key": "Completed Orders"},
  ].obs;
  RxBool isAdmin = true.obs;
  RxInt selectedIndex = 0.obs;
  RxList menus = [].obs;
  RxList orders = [].obs;
  RxList inventorys = [].obs;
}
