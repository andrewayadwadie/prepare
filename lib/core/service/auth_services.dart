import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class AuthServices {
  static Future login({
    required String email,
    required String password,
  }) async {
    var url = "${apiUrl}Account/Login";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"Email": email, "Password": password}));
      log(" response status from login ${res.statusCode}");
      if (res.statusCode == 200 || res.statusCode == 201) {
        var registerDataJson = jsonDecode(res.body)['data'];
        log(" response body from login ${res.body}");
        return [
          registerDataJson['token'], // 0 token
          registerDataJson['expiresOn'], // 1 expire date
        ];
      }
      if (res.statusCode == 400) {
        log(" response body from login ${res.body}");
        var registerDataJson = jsonDecode(res.body);

        return registerDataJson['errors'][0][0];
      }
    } catch (e) {
      throw "exception is : $e";
    }
  }

}
