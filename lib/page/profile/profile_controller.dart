import 'package:flutter_playground/domain/entity/user.dart';
import 'package:flutter_playground/domain/usecases/me_usecase.dart';
import 'package:flutter_playground/enum/view_state.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final MeUseCase _meUseCase;
  var user = const ViewState<User>.initial().obs;

  ProfileController(this._meUseCase);

  Future<void> load() async {
    user.value = const ViewState.loading();
    update();
    final res = await _meUseCase.execute();
    res.maybeWhen(
      orElse: () {},
      success: (userData) {
        user.value = ViewState.success(data: userData);
        update();
      },
      error: (message) {
        user.value = ViewState.error(message: message);
        update();
      },
    );
  }
}
