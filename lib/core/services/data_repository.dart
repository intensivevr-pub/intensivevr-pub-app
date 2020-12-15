import 'dart:convert';

import 'package:intensivevr_pub/core/models/event.dart';
import 'package:intensivevr_pub/core/models/models.dart';
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

  static Future getPrizes(
      AuthenticationBloc authenticationBloc, int threshold, int portion) async {
    String apiUrl =
        "/api/prizes/sort/1/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(response.body);
    print(data);
    return data.map((rawPrize) {
      return Prize.fromJson(rawPrize);
    }).toList();
  }

  static Future getDiscounts(
      AuthenticationBloc authenticationBloc, int threshold, int portion) async {
    String apiUrl =
        "/api/discounts/type/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(response.body);
    return data.map((rawDiscount) {
      return Discount.fromJson(rawDiscount);
    }).toList();
  }

  static Future getGames(
      AuthenticationBloc authenticationBloc, int threshold, int portion) async {
    String apiUrl =
        "/api/games/type/all/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(response.body);
    //print(data);
    return data.map((rawGame) {
      return Game.fromJson(rawGame);
    }).toList();
  }

  static Future getProducts(
      AuthenticationBloc authenticationBloc, int threshold, int portion) async {
    String apiUrl =
        "/api/products/sort/1/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(response.body);
    //print(data);
    return data.map((rawProduct) {
      return Product.fromJson(rawProduct);
    }).toList();
  }

  static Future getEvents(
      AuthenticationBloc authenticationBloc, int threshold, int portion) async {
    String apiUrl =
        "/api/events/status/2/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(response.body);
    //print(data);
    return data.map((rawEvent) {
      return Event.fromJson(rawEvent);
    }).toList();
  }
}
