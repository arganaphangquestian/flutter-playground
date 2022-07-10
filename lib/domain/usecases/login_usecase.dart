import 'package:flutter_playground/domain/repository/repository.dart';
import 'package:flutter_playground/enum/remote_state.dart';

class LoginUseCase {
  final Repository _repo;

  LoginUseCase(this._repo);

  Future<RemoteState<String>> execute(String email, String password) async {
    return await _repo.login(email, password);
  }
}
