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
    final data = json.decode(utf8.decode(response.bodyBytes));
    var points = data[0]['points'];
    return points;
  }

  static Future getPrizes(int threshold, int portion) async {
    String apiUrl =
        "/api/prizes/sort/1/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    //print(data);
    return data.map((rawPrize) {
      return Prize.fromJson(rawPrize);
    }).toList();
  }

  static Future getDiscounts(int threshold, int portion) async {
    String apiUrl =
        "/api/discounts/type/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    return data.map((rawDiscount) {
      return Discount.fromJson(rawDiscount);
    }).toList();
  }

  static Future getGames(int threshold, int portion) async {
    String apiUrl =
        "/api/games/type/all/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    //print(data);
    return data.map((rawGame) {
      return Game.fromJson(rawGame);
    }).toList();
  }

  static Future getProducts(int threshold, int portion) async {
    String apiUrl =
        "/api/products/sort/1/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    //print(data);
    return data.map((rawProduct) {
      return Product.fromJson(rawProduct);
    }).toList();
  }

  static Future getEvents(int threshold, int portion) async {
    String apiUrl =
        "/api/events/status/2/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    var response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    //print(data);
    return data.map((rawEvent) {
      return Event.fromJson(rawEvent);
    }).toList();
  }

  static Future getUserData(AuthenticationBloc authenticationBloc) async {
    String apiUrl = "/api/user/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    //print(data);
    return User.fromJson(data[0]);
  }

  static Future postRewardCollect(
      AuthenticationBloc authenticationBloc, int prizeID) async {
    String apiUrl = "/api/redeem/$prizeID/";
    await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.POST);
    return true;
  }

  static Future<List<Coupon>> getActiveCoupons(
      AuthenticationBloc authenticationBloc) async {
    String apiUrl = "/api/coupons/";
    var response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.GET);
    final data = json.decode(utf8.decode(response.bodyBytes));
    //print(data);
    return List<Coupon>.from(data.map((rawPrize) {
      return Coupon.fromJson(rawPrize);
    }).toList());
  }
}
