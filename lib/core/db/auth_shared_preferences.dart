


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

class UserNamePref {
  static SharedPreferences? _userNamePreferences;
  static const _username= 'username';

  static Future init() async {
    _userNamePreferences = await SharedPreferences.getInstance();
  }

/*------------------------------- UserNmae---------------------------- */
  static Future setUserNameValue(String value) async {
    await _userNamePreferences!.setString(_username, value);
  }

  static String getUserNmaeValue() {
    return _userNamePreferences!.getString(_username)!;
  }

  static Future clearUserNmae() async {
    await _userNamePreferences!.clear();
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

class UserPhonePref {
  static SharedPreferences? _userPhonePreferences;
  static const _userPhone = 'userphone';

  static Future init() async {
    _userPhonePreferences = await SharedPreferences.getInstance();
  }

/*------------------------------- UserPhone---------------------------- */
  static Future setUserPhoneValue(String value) async {
    await _userPhonePreferences!.setString(_userPhone, value);
  }

  static String getUserPhoneValue() {
    return _userPhonePreferences!.getString(_userPhone)!;
  }

  static Future clearUserPhone() async {
    await _userPhonePreferences!.clear();
  }

/*---------------------------------------------------------------------- */

}

class UserSSNPref {
  static SharedPreferences? _userSsnPreferences;
  static const _userSsn = 'userssn';

  static Future init() async {
    _userSsnPreferences = await SharedPreferences.getInstance();
  }

/*------------------------------- UserSsn---------------------------- */
  static Future setUserSsnValue(String value) async {
    await _userSsnPreferences!.setString(_userSsn, value);
  }

  static String getUserSsnValue() {
    return _userSsnPreferences!.getString(_userSsn)!;
  }

  static Future clearUserSsn() async {
    await _userSsnPreferences!.clear();
  }

/*---------------------------------------------------------------------- */

}

/*

class IsLogin {
  static SharedPreferences? _preferences;
  static const _isLoginValue = 'isLoginValue';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setIsLoginValue(bool value) async {
    await _preferences!.setBool(_isLoginValue, value);
  }

  static bool getIsLoginValue() {
    return _preferences!.getBool(_isLoginValue)!;
  }
}
*/