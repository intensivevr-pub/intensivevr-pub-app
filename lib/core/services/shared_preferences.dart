import 'package:intensivevr_pub/core/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String darkModeEnabled = 'darkModeEnabled';
  static const String userStored = 'userStored';
  static const String userName = 'userName';
  static const String userHash = 'userHash';
}

class SharedPreferencesService {
  static SharedPreferencesService _instance;
  static SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<void> setDarkModeInfo(bool isDarkModeEnabled) async =>
      await _preferences.setBool(
          SharedPrefKeys.darkModeEnabled, isDarkModeEnabled);

  bool get isDarkModeEnabled =>
      _preferences.getBool(SharedPrefKeys.darkModeEnabled);

  Future<void> setUserInfo(User user) async {
    await _preferences.setBool(SharedPrefKeys.userStored, true);
    await _preferences.setString(SharedPrefKeys.userName, user.name);
    await _preferences.setString(SharedPrefKeys.userHash, user.hash);
  }

  bool get isUserStored => _preferences.getBool(SharedPrefKeys.userStored);

  String get userName => _preferences.getString(SharedPrefKeys.userName);

  String get userHash => _preferences.getString(SharedPrefKeys.userHash);

  Future<void> deleteUserInfo() async {
    await _preferences.setBool(SharedPrefKeys.userStored, false);
  }
}
