import 'dart:convert';

import 'package:dynamic_item_list_view_flutter_getx/app/data/model/employee_model.dart';
import 'package:dynamic_item_list_view_flutter_getx/app/modules/home/controllers/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  Rx<List<ServerModel>> servers = Rx<List<ServerModel>>([]);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  late ServerModel employeeModel;
  var itemCount = 0.obs;

  @override
  void onInit() async {
    box.read("name");
    box.read("authKey");
    box.read("count");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameTextEditingController.dispose();
    addressTextEditingController.dispose();
  }

  addEmployee(String name, String address) {
    employeeModel = ServerModel(name: name, auth: address);
    servers.value.add(employeeModel);
    itemCount.value = servers.value.length;
    nameTextEditingController.clear();
    addressTextEditingController.clear();
    box.listen(() {
      print(box.read("name"));
      print(box.read("authKey"));
    });
    box.save();
  }

  removeEmployee(int index) {
    servers.value.removeAt(index);
    itemCount.value = servers.value.length;
    box.remove("name");
    box.remove("authKey");
  }
}
