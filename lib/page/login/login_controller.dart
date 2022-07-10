import 'package:flutter_playground/domain/usecases/login_usecase.dart';
import 'package:flutter_playground/enum/view_state.dart';
import 'package:flutter_playground/main_controller.dart';
import 'package:flutter_playground/page/home/home_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  var email = 'johndoe@mail.com'.obs;
  var password = 'password'.obs;
  final login = const ViewState<String>.initial().obs;

  LoginController(this._loginUseCase);

  Future<void> loginHandler() async {
    login.value = const ViewState.loading();
    update();
    final result = await _loginUseCase.execute(email.value, password.value);
    result.maybeWhen(
      orElse: () {},
      error: (message) {
        login.value = ViewState.error(message: message);
        update();
        Get.snackbar('Login failed', message);
      },
      success: (token) {
        login.value = ViewState.success(data: token);
        update();
        Get.find<MainController>().saveLogin(token);
        Get.offAllNamed(HomePage.routeName);
      },
    );
  }
}
