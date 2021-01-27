import 'dart:convert';

import 'package:authentication_repository/const.dart';
import 'package:authentication_repository/src/models/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

class UserRepository {
  static Future<Tuple2<String, String>> login({
    @required String email,
    @required String password,
  }) async {
    Uri uri;
    if (kUseHTTPS) {
      uri = Uri.https(kServerUrl, "/auth/jwt/create/");
    } else {
      uri = Uri.http(kServerUrl, "/auth/jwt/create/");
    }
    final body = json.encode({
      'email': email,
      'password': password,
    });
    final http.Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String refresh = data['refresh'].toString();
    final String access = data['access'].toString();
    return Tuple2(refresh, access);
  }

  static Future<Either<bool, RegisterError>> register({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    Uri uri;
    if (kUseHTTPS) {
      uri = Uri.https(kServerUrl, "/auth/users/");
    } else {
      uri = Uri.http(kServerUrl, "/auth/users/");
    }
    final body = json.encode({
      'email': email,
      'password': password,
      'nick': username,
    });
    final http.Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode != 201) {
      final Map<String, dynamic> reason =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (reason['email'] != null) {
        if (reason['email'] ==
            "Istnieje już użytkownik z tą wartością pola adres email.") {
          return Right(EmailAlreadyExistsError());
        } else {
          return Right(EmailIncorrectError());
        }
      } else if (reason['nick'] != null) {
        if (reason['nick'] ==
            "Istnieje już użytkownik z tą wartością pola nazwa.") {
          return Right(UsernameTakenError());
        } else {
          return Right(UsernameIncorrectError());
        }
      }
      return Right(UnknownError());
    }
    return const Left(true);
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "refresh");
    await storage.delete(key: "auth_key");
    return;
  }

  static Future<void> persistTokenAndRefresh(
      Tuple2<String, String> data) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "refresh", value: data.value1);
    await storage.write(key: "auth_key", value: data.value2);
    return;
  }

  Future<void> persistToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "auth_key", value: token);
    return;
  }

  static bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Future<String> refreshToken() async {
    try {
      const storage = FlutterSecureStorage();
      final String refresh = await storage.read(key: "refresh");
      if (refresh != null) {
        Uri uri;
        if (kUseHTTPS) {
          uri = Uri.https(kServerUrl, "/auth/jwt/refresh/");
        } else {
          uri = Uri.http(kServerUrl, "/auth/jwt/refresh/");
        }
        final body = json.encode({
          'refresh': refresh,
        });
        final http.Response response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
        if (response.statusCode != 200) {
          return null;
        }
        final Map<String, dynamic> data =
            json.decode(response.body) as Map<String, dynamic>;
        final String auth = data["access"].toString();
        await storage.write(key: "auth_key", value: auth);
        return auth;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String> getToken() async {
    return const FlutterSecureStorage().read(key: "auth_key");
  }

  static Future<String> getTokenAndVerify() async {
    const storage = FlutterSecureStorage();
    final String auth = await storage.read(key: "auth_key");
    try {
      if (auth != null) {
        if (!isTokenExpired(auth)) {
        } else {
          return refreshToken();
        }
        Uri uri;
        if (kUseHTTPS) {
          uri = Uri.https(kServerUrl, "/auth/jwt/verify/");
        } else {
          uri = Uri.http(kServerUrl, "/auth/jwt/verify/");
        }
        final body = json.encode({
          'token': auth,
        });
        final http.Response response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
        if (response.statusCode != 200) {
          return null;
        } else {
          return auth;
        }
      } else {
        return null;
      }
    } catch (e) {
      return auth;
    }
  }
}
