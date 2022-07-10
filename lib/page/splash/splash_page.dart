import 'package:flutter/material.dart';
import 'package:flutter_playground/page/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  static const routeName = '/splash';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init();
    return const Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
