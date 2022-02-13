import 'dart:convert';
import 'dart:developer';

import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/epicenter/epicenter_model.dart';
import 'package:prepare/model/epicenter/nearst_picenter_point_model.dart';

// ignore: implementation_imports

import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class EpicenterServices {
  static Future getAllInsects() async {
    String url = "${apiUrl}Insects/GetAllInsects";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    log("status code is : ${res.statusCode}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List insects = jsonData.map((element) {
        return EpiCenterModel.fromJson(element);
      }).toList();

      return insects;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

//===================================================================
  static Future addEpiCenter(
      {required String name,
      required String lat,
      required String long,
      required String code,
      required String temperature,
      required String windSpeed,
      required String humidity,
      required String recommendation,
      required int insectId,
      required int districtId,
      required int number}) async {
    var url = "${apiUrl}Epicenters/AddEpicenter";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
          },
          body: jsonEncode({
            "Name": name,
            "Lat": lat,
            "Long": long,
            "InsectId": insectId,
            "DistrictId": districtId,
            "Code": code,
            "Temperature": temperature,
            "WindSpeed": windSpeed,
            "Humidity": humidity,
            "Recommendation": recommendation,
            "Number": number
          }));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return 200;
      } else if (res.statusCode == 400) {
        log(" response body from add epicenter ${res.body}");
        var errorData = jsonDecode(res.body);

        return errorData['errors'][0][0];
      } else if (res.statusCode == 401) {
        return 401;
      }
    } catch (e) {
      throw "exception is : $e";
    }
  }

//========================================================

  static Future getInsectsCode(int cityId, int insectId) async {
    String url = "${apiUrl}Epicenters/GetEpicenterCode/$cityId/$insectId";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    log("status code is : ${res.statusCode}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      var data = res.body;

      return data;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      return "عير مصرح للمستخدم";
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return "يوجد مشكلة ";
    } else if (res.statusCode == 400) {
      var errorMsg = jsonDecode(res.body);

      return errorMsg['errors'][0][0];
    }
  }

//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>//

static Future getNearstEpicenterVisit(double lat, double long) async {
    String url = "${apiUrl}Epicenters/GetClosestEpicenters/$lat/$long";
 http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List closeEpicenter = jsonData.map((element) {
        return NearstEpicenterModel.fromJson(element);
      }).toList();

      return closeEpicenter;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    }
    return 400;
  }

}
