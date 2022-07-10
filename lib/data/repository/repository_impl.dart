import 'package:flutter_playground/data/datasource/local_datasource.dart';
import 'package:flutter_playground/data/datasource/remote_datasource.dart';
import 'package:flutter_playground/domain/entity/user.dart';
import 'package:flutter_playground/domain/repository/repository.dart';
import 'package:flutter_playground/enum/remote_state.dart';
import 'package:flutter_playground/util/exception.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remote;
  // ignore: unused_field
  final LocalDataSource _local;
  RepositoryImpl(this._remote, this._local);

  @override
  Future<RemoteState<String>> login(String email, String password) async {
    try {
      final res = await _remote.login(email, password);
      return RemoteState.success(data: res);
    } on DatasourceException catch (e) {
      return RemoteState.error(message: e.message);
    }
  }

  @override
  Future<RemoteState<User>> me() async {
    try {
      final res = await _remote.me();
      return RemoteState.success(data: User(res.id, res.name, res.email));
    } on DatasourceException catch (e) {
      return RemoteState.error(message: e.message);
    }
  }

  @override
  Future<RemoteState<String>> refreshToken() async {
    try {
      final res = await _remote.refreshToken();
      return RemoteState.success(data: res);
    } on DatasourceException catch (e) {
      return RemoteState.error(message: e.message);
    }
  }
}
