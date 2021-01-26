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
    var uri;
    if(kUseHTTPS){
      uri = Uri.https(kServerUrl, "/auth/jwt/create/");
    }else {
      uri = Uri.http(kServerUrl, "/auth/jwt/create/");
    }
    var body = json.encode({
      'email': email,
      'password': password,
    });

    print('Body: $body');
    print("LOGUJE");
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode != 200) {
      print("Error");
      print(response.body);
      return null;
    }
    print("RESPONS");
    var data = json.decode(response.body);
    var refresh = data['refresh'];
    var access = data['access'];
    print(access);
    return Tuple2(refresh, access);
  }

  static Future<Either<bool, RegisterError>> register({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    var uri;
    if(kUseHTTPS){
      uri = Uri.https(kServerUrl, "/auth/users/");
    }else{
      uri = Uri.http(kServerUrl, "/auth/users/");
    }
    var body = json.encode({
      'email': email,
      'password': password,
      'nick': username,
    });
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode != 201) {
      var reason = json.decode(utf8.decode(response.bodyBytes));
      if(reason['email']!=null){
        if(reason['email']=="Istnieje już użytkownik z tą wartością pola adres email."){
          return Right(EmailAlreadyExistsError());
        }else{
          return Right(EmailIncorrectError());
        }
      }else if(reason['nick']!=null){
        if(reason['nick']=="Istnieje już użytkownik z tą wartością pola nazwa."){
          return Right(UsernameTakenError());
        }else{
          return Right(UsernameIncorrectError());
        }
      }
      print(reason);
      return Right(UnknownError());
    }
    return Left(true);
  }

  static Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "refresh");
    await storage.delete(key: "auth_key");
    return;
  }

  static Future<void> persistTokenAndRefresh(
      Tuple2<String, String> data) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "refresh", value: data.value1);
    await storage.write(key: "auth_key", value: data.value2);
    return;
  }

  Future<void> persistToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "auth_key", value: token);
    return;
  }

  static bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Future<String> refreshToken() async {
    try {
      final storage = new FlutterSecureStorage();
      var refresh = await storage.read(key: "refresh");
      if (refresh != null) {
        var uri;
        if(kUseHTTPS){
          uri = Uri.https(kServerUrl, "/auth/jwt/refresh/");

        }else {
          uri = Uri.http(kServerUrl, "/auth/jwt/refresh/");
        }
        var body = json.encode({
          'refresh': refresh,
        });
        var response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
        if (response.statusCode != 200) {
          return null;
        }
        var data = json.decode(response.body);
        String auth = data["access"];
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
    return await FlutterSecureStorage().read(key: "auth_key");
  }

  static Future<String> getTokenAndVerify() async {
    final storage = new FlutterSecureStorage();
    var auth = await storage.read(key: "auth_key");
    try {
      if (auth != null) {
        if (!isTokenExpired(auth)) {
        } else {
          return refreshToken();
        }
        var uri;
        if(kUseHTTPS){
          uri = Uri.https(kServerUrl, "/auth/jwt/verify/");
        }else {
          uri = Uri.http(kServerUrl, "/auth/jwt/verify/");
        }
        var body = json.encode({
          'token': auth,
        });
        var response = await http.post(
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
