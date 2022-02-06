import 'dart:convert';
import 'dart:developer';

import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/epicenter/all_epicenter_model.dart';
 
// ignore: implementation_imports

import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class AllEpicenterServices {
  static Future getAllEpicenter() async {
    String url = "${apiUrl}Epicenters/GetAllEpicenters";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZHZpc29yIiwianRpIjoiODFmNTM5ZWUtMDlmMy00MDVkLWE0NGUtODY1ZDJmOGEzY2Q2IiwiZW1haWwiOiJBZHZpc29yQGdtYWlsLmNvbSIsInVpZCI6ImI3NGRkZDE0LTYzNDAtNDg0MC05NWMyLWRiMTI1NTQ4NDNlNSIsInJvbGVzIjoiQWR2aXNvciIsImV4cCI6MTY0NDIzNjc4NiwiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.19CJKMiGOvh4vC6serxsm-zttJghQd0PXLgRLA7HD08',
      },
    );
    log("status code is : ${res.statusCode}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List epicenters = jsonData.map((element) {
        return AllEpicenterModel.fromJson(element);
      }).toList();

      return epicenters;
    } else if (res.statusCode == 401||res.statusCode == 403) {
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
        log(" response body from login ${res.body}");
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
