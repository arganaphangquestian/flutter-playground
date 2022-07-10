import 'package:flutter_playground/domain/repository/repository.dart';
import 'package:flutter_playground/enum/remote_state.dart';

class RefreshTokenUseCase {
  final Repository _repo;

  RefreshTokenUseCase(this._repo);

  Future<RemoteState<String>> execute() async {
    return await _repo.refreshToken();
  }
}
