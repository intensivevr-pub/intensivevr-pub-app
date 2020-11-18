import 'dart:async';

import 'package:authentication_repository/src/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

import 'models/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationException implements Exception {}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  User user;

  Stream<AuthenticationStatus> get status async* {
    String key = await UserRepository.getTokenAndVerify();

    if (key != null) {
      user = User(key);
      yield AuthenticationStatus.authenticated;
    } else
      yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);
    Tuple2<String, String> result =
        await UserRepository.login(email: username, password: password);
    if (result != null) {
      UserRepository.persistTokenAndRefresh(result);
      user = User(result.item2);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw AuthenticationException();
    }
  }

  Future<void> register({
    @required String username,
    @required String password,
    @required String email,
  }) async {
    assert(username != null);
    assert(password != null);
    assert(email != null);
    bool isRegisterSuccessful = await UserRepository.register(
        email: email, password: password, username: username);
    if (isRegisterSuccessful) {
      Tuple2<String, String> result =
          await UserRepository.login(email: email, password: password);
      if (result != null) {
        UserRepository.persistTokenAndRefresh(result);
        user = User(result.item2);
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        throw AuthenticationException();
      }
    } else {
      throw AuthenticationException();
    }
  }

  User getUser() {
    if (user == null) throw AuthenticationException();
    return user;
  }

  void logOut() {
    user = null;
    UserRepository.deleteToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
