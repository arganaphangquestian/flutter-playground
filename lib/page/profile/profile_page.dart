import 'package:flutter/material.dart';
import 'package:flutter_playground/main_controller.dart';
import 'package:flutter_playground/page/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text('${mainController.user.value?.name}')),
              Obx(() => Text('${mainController.user.value?.email}')),
            ],
          ),
        ),
      ),
    );
  }
}
