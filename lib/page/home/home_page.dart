import 'package:flutter/material.dart';
import 'package:flutter_playground/main_controller.dart';
import 'package:flutter_playground/page/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.find<MainController>().logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToProfile();
        },
        child: const Icon(Icons.person),
      ),
      body: Center(
        child: Obx(
          () => Text(
            'Name ${Get.find<MainController>().user.value?.name}\nGet from local data',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
