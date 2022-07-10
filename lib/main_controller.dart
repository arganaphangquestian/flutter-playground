import 'package:flutter_playground/domain/entity/user.dart';
import 'package:flutter_playground/page/login/login_page.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'util/persistance.dart';

class MainController extends GetxController {
  var isLoggedIn = false.obs;
  Rx<User?> user = null.obs;

  MainController() {
    final token = Get.find<AppPref>().token;
    if (token.val.isEmpty) {
      return;
    }
    final usermap = JwtDecoder.decode(token.val)['data'];
    user = User(usermap['id'], usermap['name'], usermap['email']).obs;
    update();
  }

  void saveLogin(String token) {
    final tokenApp = Get.find<AppPref>().token;
    tokenApp.val = token;
  }

  void logout() {
    final tokenApp = Get.find<AppPref>().token;
    tokenApp.val = '';
    Get.offAllNamed(LoginPage.routeName);
  }
}
