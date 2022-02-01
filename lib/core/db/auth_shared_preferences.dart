


import 'package:shared_preferences/shared_preferences.dart';

class TokenPref {
  static SharedPreferences? _loginPreferences ;
  static const _token = 'usertoken';

  static Future init() async {
    _loginPreferences = await SharedPreferences.getInstance();
  }

/*------------------------------- Token---------------------------- */
  static Future setTokenValue(String value ) async {
    await _loginPreferences!.setString(_token, value);
  }

  static String getTokenValue() {
    return _loginPreferences!.getString(_token)??'';
  }

  static Future clearToken() async {
    await _loginPreferences!.clear();
  }

/*---------------------------------------------------------------------- */

}
class ExpireDatePref {
  static SharedPreferences? _expireDatePreferences;
  static const _expireDate = 'expiredate';

  static Future init() async {
    _expireDatePreferences = await SharedPreferences.getInstance();
  }

/*------------------------------- Expire Date---------------------------- */
  static Future setExpireDateValue(String value) async {
    await _expireDatePreferences!.setString(_expireDate, value);
  }

  static String getExpireDateValue() {
    return _expireDatePreferences!.getString(_expireDate)!;
  }

  static Future clearExpireDate() async {
    await _expireDatePreferences!.clear();
  }

/*---------------------------------------------------------------------- */

}

