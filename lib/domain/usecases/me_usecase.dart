import 'package:flutter_playground/domain/entity/user.dart';
import 'package:flutter_playground/domain/repository/repository.dart';
import 'package:flutter_playground/enum/remote_state.dart';

class MeUseCase {
  final Repository _repo;

  MeUseCase(this._repo);

  Future<RemoteState<User>> execute() async {
    return await _repo.me();
  }
}
