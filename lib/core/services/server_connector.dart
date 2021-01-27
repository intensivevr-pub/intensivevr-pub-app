import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intensivevr_pub/const.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum requestType { get, post, put }

class ServerConnectionException implements Exception {}

class ServerConnector {
  static bool _isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Future<String> _handleAuthorization(
      AuthenticationBloc authBloc) async {
    String token = authBloc.state.user.authToken;
    if (_isTokenExpired(token)) {
      token = await authBloc.authenticationRepository.refreshToken();
      if (token == null) {
        throw ServerConnectionException();
      }
    }
    return token;
  }

  static Future<http.Response> makeRequest(
      String url, AuthenticationBloc authBloc, requestType type) async {
    final String token = await _handleAuthorization(authBloc);
    Uri uri;
    if (kUseHTTPS) {
      uri = Uri.https(kServerUrl, url);
    } else {
      uri = Uri.http(kServerUrl, url);
    }
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Future<http.Response> Function(dynamic url, {Map<String, String> headers})
        request;
    switch (type) {
      case requestType.get:
        request = http.get;
        break;
      case requestType.post:
        request = http.post;
        break;
      case requestType.put:
        request = http.put;
        break;
    }
    final http.Response response = await request(uri, headers: headers);
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      authBloc.add(AuthenticationLogoutRequested());
    } else {
      print("ERROR code: ${response.statusCode}");
      print(json.decode(response.body));
      throw ServerConnectionException();
    }
    return null;
  }

  static Future<http.Response> makeRequestWithoutToken(String url, requestType type) async {
    Uri uri;
    if (kUseHTTPS) {
      uri = Uri.https(kServerUrl, url);
    } else {
      uri = Uri.http(kServerUrl, url);
    }
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Future<http.Response> Function(dynamic url, {Map<String, String> headers})
        request;
    switch (type) {
      case requestType.get:
        request = http.get;
        break;
      case requestType.post:
        request = http.post;
        break;
      case requestType.put:
        request = http.put;
        break;
    }
    final http.Response response = await request(uri, headers: headers);
    if (response.statusCode == 200) {
      return response;
    } else {
      print("ERROR code: ${response.statusCode}");
      print(json.decode(response.body));
      throw ServerConnectionException();
    }
  }
}
