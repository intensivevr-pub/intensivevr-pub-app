import 'dart:async';

import 'package:authentication_repository/src/models/errors.dart';
import 'package:authentication_repository/src/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

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
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    Tuple2<String, String> result =
        await UserRepository.login(email: email, password: password);
    if (result != null) {
      UserRepository.persistTokenAndRefresh(result);
      user = User(result.value2);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw AuthenticationException();
    }
  }

  Future<Either<bool, RegisterError>> register({
    @required String username,
    @required String password,
    @required String email,
  }) async {
    assert(username != null);
    assert(password != null);
    assert(email != null);
    return await UserRepository.register(
        email: email, password: password, username: username);
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

  Future<String> refreshToken() async {
    String auth = await UserRepository.refreshToken();
    if (auth != null) {
      user = User(auth);
      _controller.add(AuthenticationStatus.authenticated);
      return auth;
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
      return null;
    }
  }

  void dispose() => _controller.close();
}
