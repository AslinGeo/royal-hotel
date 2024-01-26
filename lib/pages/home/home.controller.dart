import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/constants.dart';
import 'package:royal_hotel/pages/home/home.variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with HomeVariables {
  init() {
    checkAdmin();
    getData();
    getEmail();
    getName();
    getChefList();
  }

  checkAdmin() async {
    SharedPreferences sharedPreferences = await prefs;
    isAdmin.value = sharedPreferences.getBool('isAdmin')!;
    isAdmin.refresh();
  }

  getName() async {
    SharedPreferences sharedPreferences = await prefs;
    String name = sharedPreferences.getString('username')!;
    userName = name;
  }

  getEmail() async {
    SharedPreferences sharedPreferences = await prefs;
    String email = sharedPreferences.getString('email')!;
    userEmail = email;
  }

  getData() {
    switch (selectedIndex.value) {
      case 0:
        if (isAdmin.value) {
          getMenus();
        } else {
          getChefOrders();
        }
        break;
      case 1:
        if (isAdmin.value) {
          getInventorys();
        } else {
          getChefAssignedOrders();
        }
        break;
      case 2:
        if (isAdmin.value) {
          getOrders();
        } else {
          getchefCompletedOrders();
        }
        break;
      default:
    }
  }

  getMenus() async {
    menus.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    DatabaseEvent data = await reference.once();
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic menusData = data.snapshot.value;

      // Loop through the menu items
      menusData!.forEach((key, value) {
        if (value["status"] == "") {
          Map data = {};
          data["uid"] = value["uid"];
          data["url"] = value["url"];
          data["name"] = value["name"];
          data["description"] = value["description"];
          data["price"] = value["price"];
          data["status"] = value["status"];
          menus.add(data);
        }
      });
    }
    menus.refresh();
  }

  getOrders() async {
    orders.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    DatabaseEvent data = await reference.once();
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic ordersData = data.snapshot.value;

      // Loop through the menu items
      ordersData!.forEach((key, values) {
        if (values["status"] != null && values["status"] != "") {
          Map data = {};
          data["uid"] = values["uid"];
          data["url"] = values["url"];
          data["name"] = values["name"];
          data["description"] = values["description"];
          data["price"] = values["price"];
          data["status"] = values["status"];

          data["assignedUid"] = values["assignedUid"];

          orders.add(data);
        }
      });
    }

    orders.refresh();
  }

  getInventorys() async {
    inventorys.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('inventory');
    DatabaseEvent data = await reference.once();
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic inventoryData = data.snapshot.value;

      // Loop through the menu items
      inventoryData!.forEach((key, values) {
        Map data = {};
        data["uid"] = values["uid"];
        data["url"] = values["url"];
        data["name"] = values["name"];
        data["description"] = values["description"];
        data["price"] = values["price"];

        inventorys.add(data);
      });
    }

    inventorys.refresh();
  }

  getChefList() async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('users');
    DatabaseEvent data = await reference.once();
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic userData = data.snapshot.value;

      // Loop through the menu items
      userData!.forEach((key, values) {
        Map data = {};
        data["name"] = values["username"];
        data["email"] = values["email"];
        data["uid"] = values["uid"];

        userList.value.add(data);
      });
    }
  }

  getChefOrders() async {
    chefOrders.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    DatabaseEvent data = await reference.once();
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic chefOrders = data.snapshot.value;

      // Loop through the menu items
      chefOrders!.forEach((key, values) {
        if (values["status"] != null &&
            values["status"] == AppConstants.placeOrder) {
          Map data = {};
          data["uid"] = values["uid"];
          data["url"] = values["url"];
          data["name"] = values["name"];
          data["description"] = values["description"];
          data["price"] = values["price"];
          data["status"] = values["status"];

          data["assignedUid"] = values["assignedUid"];

          chefOrders.add(data);
        }
      });
    }

    chefOrders.refresh();
  }

  getChefAssignedOrders() async {
    chefAssignedOrders.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    DatabaseEvent data = await reference.once();
    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic chefAssignedOrders = data.snapshot.value;

      // Loop through the menu items
      chefAssignedOrders!.forEach((key, values) {
        if (values["status"] != null &&
            values["status"] == AppConstants.assignedOrder &&
            values["assignedUid"] == userId) {
          Map data = {};
          data["uid"] = values["uid"];
          data["url"] = values["url"];
          data["name"] = values["name"];
          data["description"] = values["description"];
          data["price"] = values["price"];
          data["status"] = values["status"];

          data["assignedUid"] = values["assignedUid"];

          chefAssignedOrders.add(data);
        }
      });
    }

    chefAssignedOrders.refresh();
  }

  getchefCompletedOrders() async {
    chefCompletedOrders.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    DatabaseEvent data = await reference.once();
    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (data.snapshot.exists) {
      // Get the value (map) from the snapshot
      dynamic chefCompletedOrders = data.snapshot.value;

      // Loop through the menu items
      chefCompletedOrders!.forEach((key, values) {
        if (values["status"] != null &&
            values["status"] == AppConstants.completedOrder &&
            values["assignedUid"] == userId) {
          Map data = {};
          data["uid"] = values["uid"];
          data["url"] = values["url"];
          data["name"] = values["name"];
          data["description"] = values["description"];
          data["price"] = values["price"];
          data["status"] = values["status"];

          data["assignedUid"] = values["assignedUid"];

          chefCompletedOrders.add(data);
        }
      });
    }

    chefCompletedOrders.refresh();
  }
}
