import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/constant/appfonts.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/pages/common/card.view.dart';
import 'package:royal_hotel/pages/common/common.view.dart';
import 'package:royal_hotel/pages/home/home.controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({super.key}) {
    controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: controller.scaffoldKey,
      appBar: myAppBar(context),
      drawer: commonWidgets().drawer(controller.userName, controller.userEmail),
      body: body(),
      floatingActionButton: Obx(
          () => controller.isAdmin.value && controller.selectedIndex.value != 2
              ? FloatingActionButton(
                  backgroundColor: AppColors.lightGreen,
                  onPressed: () {
                    commonWidgets().addMenuBottomSheet(context,
                        controller.selectedIndex.value == 0 ? true : false);
                  },
                  child: const Icon(Icons.add),
                )
              : Container()),
    ));
  }

  myAppBar(context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  controller.scaffoldKey.currentState!.openDrawer();
                },
                child: Icon(
                  Icons.menu_outlined,
                  color: AppColors.lightGreen,
                ),
              ),
              Text(
                AppStrings.foodienator,
                style: AppFonts().h1.copyWith(color: AppColors.lightGreen),
              ),
              Icon(
                Icons.notifications,
                color: AppColors.lightGreen,
              )
            ],
          ),
        ));
  }

  body() {
    return DefaultTabController(
      length: controller.adminList.length, // Number of tabs
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonsTabBar(
                onTap: (index) async {
                  controller.selectedIndex.value = index;
                  controller.getData();
                },
                radius: 10.0,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: controller.isAdmin.value ? 30 : 10),
                buttonMargin: const EdgeInsets.all(7),
                backgroundColor: AppColors.lightOrange04,
                unselectedBackgroundColor: AppColors.lightGreen,
                unselectedLabelStyle:
                    AppFonts().h3.copyWith(color: AppColors.white),
                labelStyle: AppFonts().h3.copyWith(color: AppColors.black),
                tabs: controller.isAdmin.value
                    ? controller.adminList.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map data = entry.value;
                        return Tab(
                          text: data["name"],
                        );
                      }).toList()
                    : controller.chefList.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map data = entry.value;
                        return Tab(
                          text: data["name"],
                        );
                      }).toList()),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                menuList(controller.menus),
                menuList(controller.inventorys),
                menuList(controller.orders)
              ],
            ),
          )
        ],
      ),
    );
  }

  menuList(RxList dataList) {
    return Obx(() => ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              FoodCard(data: dataList[index]),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }));
  }
}
