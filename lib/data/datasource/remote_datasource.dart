import 'package:dio/dio.dart';
import 'package:flutter_playground/data/model/user_model.dart';
import 'package:flutter_playground/util/exception.dart';

abstract class RemoteDataSource {
  Future<String> login(String email, String password);
  Future<UserModel> me();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _client;
  RemoteDataSourceImpl(this._client);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _client.post('/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['data']['token'];
    } catch (e) {
      throw DatasourceException();
    }
  }

  @override
  Future<UserModel> me() async {
    try {
      final response = await _client.get('/user/me');
      final result = UserModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
      return result;
    } catch (e) {
      throw DatasourceException();
    }
  }
}
