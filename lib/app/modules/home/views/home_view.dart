import 'package:dynamic_item_list_view_flutter_getx/app/modules/home/controllers/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';
import 'accs.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  /* Future<void> verileriKaydet() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("name", controller.nameTextEditingController.text);
    preferences.setString("auth", controller.addressTextEditingController.text);
  }

  String name = "";
  String auth = "";

  void verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    name = preferences.getString("name") ?? "";
    auth = preferences.getString("company") ?? "";
  }
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameTextEditingController,
              decoration: const InputDecoration(
                hintText: "NAME",
                labelText: "NAME",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                isDense: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: controller.addressTextEditingController,
              decoration: const InputDecoration(
                hintText: "AUTH CODE",
                labelText: "AUTH CODE",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                isDense: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.addEmployee(
                    controller.nameTextEditingController.text,
                    controller.addressTextEditingController.text);
                box.read("name");
                box.read("authKey");
              },
              child: const Text("Add User"),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.itemCount.value,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(controller.servers.value[index].name!),
                      subtitle: Text(controller.servers.value[index].auth!),
                      leading: GestureDetector(
                        child: const Icon(
                          Icons.settings,
                          color: Colors.black45,
                        ),
                        onTap: () async {
                          await box.write(
                              "authKey", controller.servers.value[index].auth);
                          await box.write(
                              "name", controller.servers.value[index].name);

                          await box.write("count", controller.itemCount.value);

                          var deneme = box.read("authKey");
                          print(deneme);

                          var deneme2 = box.read("name");
                          print(deneme2);
                          Navigator.of(context).push(MaterialPageRoute(
                            // ignore: prefer_const_constructors
                            builder: (context) => MyHomePage(
                              title: 'GENERATOR',
                            ),
                          ));
                        },
                      ),
                      trailing: GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          controller.removeEmployee(index);
                        },
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
