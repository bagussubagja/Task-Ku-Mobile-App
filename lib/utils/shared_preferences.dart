import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_ku_mobile_app/constants/constants.dart';

class SharedPrefsHelper {
  static Future<bool> saveUserDisplayName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(Constants.userDisplayName, value);
  }

  static Future<String> getUserDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.userDisplayName)!;
  }

  static Future<bool> saveThemeState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(Constants.themeState, value);
  }

  static Future<bool> getThemeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.themeState)!;
  }

  static Future clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
