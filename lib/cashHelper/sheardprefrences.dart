import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }


  static bool? getDataOnBoarding({required String key}) {
    return sharedPreferences!.getBool(key);
  }

  static String? getDataName() {
    var name = sharedPreferences!.getString('userName');
    if (name != null) {
      return name;
    } else {
      return 'user';
    }
  }
}
