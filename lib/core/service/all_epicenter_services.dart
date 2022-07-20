import 'dart:convert';

import 'package:http/http.dart' as http;
// ignore: implementation_imports

import 'package:prepare/utils/constants.dart';

import '../../model/epicenter/all_epicenter_model.dart';
import '../db/auth_shared_preferences.dart';

class AllEpicenterServices {
  static Future getAllEpicenter() async {
    String url = "${apiUrl}Epicenters/GetAllEpicenters";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization':
            'Bearer ${TokenPref.getTokenValue()}',
      },
    );

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List epicenters = jsonData.map((element) {
        return AllEpicenterModel.fromJson(element);
      }).toList();

      return epicenters;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

  static Future addVisitEpiCenter({
    required String temperature,
    required String windSpeed,
    required String humidity,
    required String recommendation,
    required int epicenterId,
    d,
  }) async {
    var url = "${apiUrl}Visits/AddVisit";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
          },
          body: jsonEncode({
            "Temperature": temperature,
            "WindSpeed": windSpeed,
            "Humidity": humidity,
            "Recommendation": recommendation,
            "EpicenterId": epicenterId
          }));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return 200;
      } else if (res.statusCode == 400) {
        var errorData = jsonDecode(res.body);
        return errorData['errors'][0][0];
      } else if (res.statusCode == 401) {
        return 401;
      }
    } catch (e) {
      throw "exception is : $e";
    }
  }
}
