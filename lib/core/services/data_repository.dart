import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intensivevr_pub/core/models/event.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';

import 'server_connector.dart';

class DataRepository {
  static Future getUserPoints(AuthenticationBloc authenticationBloc) async {
    const String apiUrl = "/api/points/";
    final http.Response response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.get);
    final data = json.decode(utf8.decode(response.bodyBytes));
    final points = data[0]['points'];
    return points;
  }

  static Future getPrizes(int threshold, int portion) async {
    final String apiUrl =
        "/api/prizes/sort/1/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    final http.Response response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    return data.map((rawPrize) {
      final Map<String, dynamic> properPrize = rawPrize as Map<String, dynamic>;
      return Prize.fromJson(properPrize);
    }).toList();
  }

  static Future getDiscounts(int threshold, int portion) async {
    final String apiUrl =
        "/api/discounts/type/all/portion/${portion ?? -1}/threshold/$threshold/";
    final http.Response response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    return data.map((rawDiscount) {
      final Map<String, dynamic> properDiscount =
          rawDiscount as Map<String, dynamic>;
      return Discount.fromJson(properDiscount);
    }).toList();
  }

  static Future<List<Game>> getGames(int threshold, int portion) async {
    final String apiUrl =
        "/api/games/type/all/category/all/portion/${portion ?? -1}/threshold/${threshold ?? 0}/";
    final http.Response response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.get);
    final List<dynamic> data =
        jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    return List<Game>.from(data.map((rawGame) {
      final Map<String, dynamic> properGame = rawGame as Map<String, dynamic>;
      return Game.fromJson(properGame);
    }).toList());
  }

  static Future getProducts(int threshold, int portion) async {
    final String apiUrl =
        "/api/products/sort/1/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    final http.Response response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    return data.map((rawProduct) {
      final Map<String, dynamic> properProduct =
          rawProduct as Map<String, dynamic>;
      return Product.fromJson(properProduct);
    }).toList();
  }

  static Future getEvents(int threshold, int portion) async {
    final String apiUrl =
        "/api/events/status/2/category/all/portion/${portion ?? -1}/threshold/$threshold/";
    final http.Response response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    return data.map((rawEvent) {
      final Map<String, dynamic> properEvent = rawEvent as Map<String, dynamic>;
      return Event.fromJson(properEvent);
    }).toList();
  }

  static Future getUserData(AuthenticationBloc authenticationBloc) async {
    const String apiUrl = "/api/user/";
    final http.Response response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    final Map<String, dynamic> properUser = data[0] as Map<String, dynamic>;
    return User.fromJson(properUser);
  }

  static Future postRewardCollect(
      AuthenticationBloc authenticationBloc, int prizeID) async {
    final String apiUrl = "/api/redeem/$prizeID/";
    await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.post);
    return true;
  }

  static Future<List<Coupon>> getActiveCoupons(
      AuthenticationBloc authenticationBloc) async {
    const String apiUrl = "/api/coupons/";
    final http.Response response = await ServerConnector.makeRequest(
        apiUrl, authenticationBloc, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    return List<Coupon>.from(data.map((rawPrize) {
      final Map<String, dynamic> properPrize = rawPrize as Map<String, dynamic>;
      return Coupon.fromJson(properPrize);
    }).toList());
  }

  static Future<List<LeaderBoardEntry>> getLeaderboard(
      Game game, int count) async {
    final String apiUrl = "/api/rank/game/${game.id}/count/$count/";
    final response =
        await ServerConnector.makeRequestWithoutToken(apiUrl, requestType.get);
    final List<dynamic> data =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    //print(data);
    return List<LeaderBoardEntry>.from(data.map(
      (rawLeaderBoardEntry) {
        final Map<String, dynamic> properEntry =
            rawLeaderBoardEntry as Map<String, dynamic>;
        return LeaderBoardEntry.fromJson(properEntry);
      },
    ).toList());
  }
}
