import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_hotel/constant/appasstes.dart';
import 'package:royal_hotel/constant/appcolors.dart';
import 'package:royal_hotel/constant/appfonts.dart';
import 'package:royal_hotel/constant/appstrings.dart';
import 'package:royal_hotel/route/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class commonWidgets {
  drawer(name, email) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.lightGreen02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Text(commonWidgets().getTitleImage(name)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: AppFonts().h3Bold.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  email,
                  style: AppFonts().h3Bold.copyWith(color: AppColors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed(AppPaths.splash);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: AppColors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "logout".tr,
                    style: AppFonts().h3.copyWith(color: AppColors.black),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  addMenuBottomSheet(context, bool isMenu, {menuData}) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final picker = ImagePicker();
    RxBool isLoading = false.obs;
    final DatabaseReference database = FirebaseDatabase.instance.ref();

    File? image;
    RxString filePath = "".obs;
    uploadImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        image = File(pickedFile.path);
      }

      if (image != null) {
        try {
          isLoading.value = true;
          isLoading.refresh();
          final Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
          await storageRef.putFile(image!);
          String downloadUrl = await storageRef.getDownloadURL();

          // Now you can store downloadUrl in Firebase Realtime Database or perform any other operations
          print('Image uploaded. Download URL: $downloadUrl');
          filePath.value = downloadUrl;
          isLoading.value = false;
        } catch (e) {
          isLoading.value = false;
          print('Error uploading image: $e');
        }
      }
    }

    if (menuData != null) {
      nameController.text = menuData["name"];
      descriptionController.text = menuData["description"];
      priceController.text = menuData["price"];
      filePath.value = menuData["url"];
    }

    return showModalBottomSheet(
      backgroundColor: AppColors.white,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Obx(() => Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "back".tr,
                            style: AppFonts()
                                .h3
                                .copyWith(color: AppColors.lightGreen),
                          ),
                        ),
                        Text(
                          isMenu ? "addMenu".tr : "addInventory".tr,
                          style: AppFonts()
                              .h3
                              .copyWith(color: AppColors.lightGreen),
                        ),
                        Container()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading.value
                      ? CircularProgressIndicator(
                          color: AppColors.lightGreen,
                        )
                      : filePath.value == ""
                          ? InkWell(
                              onTap: () async {
                                await uploadImage();
                              },
                              child: const Icon(
                                Icons.insert_drive_file,
                                size: 100,
                                color: Colors.grey,
                              ),
                            )
                          : Image.network(
                              filePath.value,
                              height: 250,
                              width: 300,
                            ),
                  const SizedBox(
                    height: 15,
                  ),
                  filePath.value == "" ? Text("uplodHere".tr) : Container(),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        validator: (value) {},
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "name".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        validator: (value) {},
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: "description".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        validator: (value) {},
                        controller: priceController,
                        decoration: InputDecoration(
                          prefix: null,
                          hintText: "price".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () async {
                        if (nameController.text.trim() == "" ||
                            priceController.text.trim() == "") {
                          snackbar("", "validationMsg".tr);
                        } else {
                          var uuid = Uuid();
                          String uniqueUid = uuid.v4();
                          if (isMenu) {
                            await database
                                .child('menus')
                                .child(menuData != null
                                    ? menuData["uid"]
                                    : uniqueUid)
                                .set({
                              'uid': menuData != null
                                  ? menuData["uid"]
                                  : uniqueUid,
                              'url': filePath.value,
                              'name': nameController.text,
                              'description': descriptionController.text,
                              'price': priceController.text,
                              'status': ''
                            });
                          } else {
                            await database
                                .child('inventory')
                                .child(menuData != null
                                    ? menuData["uid"]
                                    : uniqueUid)
                                .set({
                              'uid': menuData != null
                                  ? menuData["uid"]
                                  : uniqueUid,
                              'url': filePath.value,
                              'name': nameController.text,
                              'description': descriptionController.text,
                              'price': priceController.text,
                            });
                          }
                          Get.back();
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.lightGreen),
                              child: Center(
                                  child: Text(
                                isMenu ? "createMenu".tr : "createInventory".tr,
                                style: AppFonts()
                                    .h2
                                    .copyWith(color: AppColors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  snackbar(title, content) {
    return Get.snackbar(
      title,
      content,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  String getTitleImage(String data) {
    final trimmedData = data.trim();
    final splitted = trimmedData.split(RegExp(
        r'\s+')); // Use a regular expression to split on one or more spaces

    if (splitted.isEmpty) {
      return ''; // Handle the case where the string contains only spaces
    }

    // return (splitted[0][0] + (splitted.length > 1 ? splitted[1][0] : 'x'))
    //     .toUpperCase();
    return "";
  }
}
