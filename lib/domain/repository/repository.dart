import 'package:flutter_playground/domain/entity/user.dart';
import 'package:flutter_playground/enum/remote_state.dart';

abstract class Repository {
  Future<RemoteState<String>> login(String email, String password);
  Future<RemoteState<User>> me();
}
