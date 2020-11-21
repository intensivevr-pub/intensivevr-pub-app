import 'dart:convert';

import 'package:intensivevr_pub/features/authentication/authentication.dart';

import 'server_connector.dart';

class DataRepository {
  static Future getUserPoints(AuthenticationBloc authenticationBloc) async {
    String apiUrl = "/api/points/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(response.body);
    var points = data[0]['points'];
    return points;
  }
}
