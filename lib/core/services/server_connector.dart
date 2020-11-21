import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intensivevr_pub/const.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum requestType { GET, POST, PUT }

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

  static Future makeRequest(
      String url, AuthenticationBloc authBloc, requestType type) async {
    String token = await _handleAuthorization(authBloc);
    var uri;
    if (kUseHTTPS) {
      uri = Uri.https(kServerUrl, url);
    } else {
      uri = Uri.http(kServerUrl, url);
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request;
    switch (type) {
      case requestType.GET:
        request = http.get;
        break;
      case requestType.POST:
        request = http.post;
        break;
      case requestType.PUT:
        request = http.put;
        break;
    }
    var response = await request(uri, headers: headers);
    if (response.statusCode == 200) {
      return response;
    } else {
      print(json.decode(response.body));
      throw ServerConnectionException();
    }
  }
}
