import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _pref;
  static const _token = 'usertoken';
  static const _expireDate = 'expiredate';
  static const _role = 'role';
  static const _name = 'name';

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

//*------------------------------- Token---------------------------- */
  static Future setTokenValue(String value) async {
    await _pref!.setString(_token, value);
  }

  static String getTokenValue() {
    return _pref!.getString(_token) ?? '';
  }

  static Future clearToken() async {
    await _pref!.remove(_token);
  }

//*------------------------------- Expire Date---------------------------- */
  static Future setExpireDateValue(String value) async {
    await _pref!.setString(_expireDate, value);
  }

  static String getExpireDateValue() {
    return _pref!.getString(_expireDate) ?? "";
  }

  static Future clearExpireDate() async {
    await _pref!.remove(_expireDate);
  }

//*---------------------------------------------------------------------- */
//*------------------------------- role ---------------------------- */
  static Future setRoleValue(String value) async {
    await _pref!.setString(_role, value);
  }

  static String getRoleValue() {
    return _pref!.getString(_role)!;
  }

  static Future clearRole() async {
    await _pref!.remove(_role);
  }

//*---------------------------------------------------------------------- */
//*-----------------------User Name-------------------------------------- */
  static Future setUserNameValue(String value) async {
    await _pref!.setString(_name, value);
  }

  static String getUserNameValue() {
    return _pref!.getString(_name)!;
  }

  static Future clearUserName() async {
    await _pref!.remove(_name);
  }
//*---------------------------------------------------------------------- */
}
