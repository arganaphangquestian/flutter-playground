import 'package:flutter/material.dart';
import 'package:flutter_playground/profile.dart';
import 'package:flutter_playground/profile_controller.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ProfileController());
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Profile(),
    );
  }
}
