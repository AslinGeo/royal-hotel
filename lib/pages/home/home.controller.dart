import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:royal_hotel/constant/constants.dart';
import 'package:royal_hotel/pages/home/home.variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with HomeVariables {
  init() {
    getData();
    getEmail();
    getName();
  }

  getName() async {
    SharedPreferences sharedPreferences = await prefs;
    String name = sharedPreferences.getString('name')!;
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
        getMenus();
        break;
      case 1:
        getInventorys();
        break;
      case 2:
        getOrders();
        break;
      default:
    }
  }

  getMenus() async {
    menus.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    var data = await reference.once();
    reference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;

      Map<dynamic, dynamic> values =
          dataSnapshot.value as Map<dynamic, dynamic>;

      values.forEach((key, values) {
        if (values["status"] == "") {
          Map data = {};
          data["uid"] = values["uid"];
          data["url"] = values["url"];
          data["name"] = values["name"];
          data["description"] = values["description"];
          data["price"] = values["price"];
          data["status"] = values["status"];
          menus.add(data);
        }
      });
    });
    menus.refresh();
  }

  getOrders() async {
    orders.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('menus');
    var data = await reference.once();
    reference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;

      Map<dynamic, dynamic> values =
          dataSnapshot.value as Map<dynamic, dynamic>;

      values.forEach((key, values) {
        if (values["status"] == AppConstants.placeOrder) {
          Map data = {};
          data["uid"] = values["uid"];
          data["url"] = values["url"];
          data["name"] = values["name"];
          data["description"] = values["description"];
          data["price"] = values["price"];
          data["status"] = values["status"];
          orders.add(data);
        }
      });
    });
    orders.refresh();
  }

  getInventorys() async {
    inventorys.clear();
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('inventory');
    var data = await reference.once();
    reference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;

      Map<dynamic, dynamic> values =
          dataSnapshot.value as Map<dynamic, dynamic>;

      values.forEach((key, values) {
        Map data = {};
        data["uid"] = values["uid"];
        data["url"] = values["url"];
        data["name"] = values["name"];
        data["description"] = values["description"];
        data["price"] = values["price"];

        inventorys.add(data);
      });
    });
    inventorys.refresh();
  }
}
