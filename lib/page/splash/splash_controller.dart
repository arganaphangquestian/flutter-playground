import 'package:flutter_playground/main_controller.dart';
import 'package:flutter_playground/page/home/home_page.dart';
import 'package:flutter_playground/page/login/login_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void init() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        Get.offAllNamed(
          Get.find<MainController>().user.value != null
              ? HomePage.routeName
              : LoginPage.routeName,
        );
      },
    );
  }
}
