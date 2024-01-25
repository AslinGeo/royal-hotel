import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/constant/appfonts.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/constant/constants.dart';
import 'package:royal_hotel/pages/common/common.view.dart';
import 'package:royal_hotel/pages/home/home.controller.dart';

class FoodCard extends StatelessWidget {
  final Map data;

  FoodCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                data["url"],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      data["status"] == null || data["status"] == ""
                          ? Container()
                          : Text(
                              data["status"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data["description"],
                    maxLines: 5,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  data["status"] != null && data["status"] == ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () async {
                                    await commonWidgets().addMenuBottomSheet(
                                        context,
                                        data["status"] != null ? true : false,
                                        menuData: data);
                                    Get.put(HomeController());
                                    Get.find<HomeController>().getData();
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.lightGreen,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    DatabaseReference reference =
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child('menus')
                                            .child(data["uid"]);
                                    reference.remove();
                                    Get.put(HomeController());
                                    Get.find<HomeController>().getData();
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                DatabaseReference reference = FirebaseDatabase
                                    .instance
                                    .ref()
                                    .child('menus')
                                    .child(data["uid"]);
                                reference.update(
                                    {"status": AppConstants.placeOrder});
                                Get.put(HomeController());
                                Get.find<HomeController>().getData();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.lightGreen,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppStrings.placeOrder,
                                    style: AppFonts()
                                        .h3
                                        .copyWith(color: AppColors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
