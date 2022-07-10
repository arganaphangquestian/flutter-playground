import 'package:flutter_playground/page/profile/profile_page.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void goToProfile() {
    Get.toNamed(ProfilePage.routeName);
  }
}
