import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../db/auth_shared_preferences.dart';

class SolvedEpicenterService {
 static Future addSolvedEpicenterService({
    required int id,
    required int type,
  }) async {
    var url = "${apiUrl}Epicenters/SolveLocation";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
          },
          body: jsonEncode({
            "id": id,
            "type": type,
          }));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return 200;
      } else if (res.statusCode == 400) {
        var registerDataJson = jsonDecode(res.body);
        return registerDataJson['errors'][0][0];
      } else if (res.statusCode == 401) {
        return 401;
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 504) {
        return 500;
      }
    } catch (e) {
      throw "exception is : $e";
    }
  }
}
