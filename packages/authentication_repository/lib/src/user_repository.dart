import 'dart:convert';

import 'package:authentication_repository/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

class UserRepository {
  static Future<Tuple2<String, String>> login({
    @required String email,
    @required String password,
  }) async {
    final uri = Uri.http(kServerUrl, "/auth/jwt/create/");
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

  static Future<bool> register({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    final uri = Uri.http(kServerUrl, "/auth/users/");
    var body = json.encode({
      'email': email,
      'password': password,
      'nick': username,
    });

    print('Body: $body');
    print("Rejestruje");
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode != 201) {
      print("Error");
      print(response.statusCode);
      print(response.body);
      return false;
    }
    print("RESPONS");
    return true;
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
    await storage.write(key: "refresh", value: data.item1);
    await storage.write(key: "auth_key", value: data.item2);
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
        final uri = Uri.http(kServerUrl, "/auth/jwt/refresh/");
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
    }catch(e){
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
        final uri = Uri.http(kServerUrl, "/auth/jwt/verify/");
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
