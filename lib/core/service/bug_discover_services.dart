import 'dart:convert';
import 'dart:developer';

import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/bug_discover/cities_model.dart';
import 'package:prepare/model/bug_discover/district_model.dart';
import 'package:prepare/model/bug_discover/fly_note_model.dart';
import 'package:prepare/model/bug_discover/fly_sample_type_model.dart';
import 'package:prepare/model/bug_discover/fly_type_model.dart';
import 'package:prepare/model/bug_discover/insect_explorations_model.dart';

import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class BugDiscoverServices {
  static Future getAllCities() async {
    String url = "${apiUrl}Cities/GetAllCities";

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

      List cities = jsonData.map((element) {
        return CitiesModel.fromJson(element);
      }).toList();

      return cities;
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

  static Future getAllDistrict(int id) async {
    String url = "${apiUrl}Districts/GetCityDistricts/$id";

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
    log("district status code is : ${res.statusCode}");
    log("district id is : $id");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List district = jsonData.map((element) {
        return DistrictModel.fromJson(element);
      }).toList();

      return district;
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

  static Future getAllFlyTypes() async {
    String url = "${apiUrl}FlyTypes/GetAllFlyTypes";

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

      List flyType = jsonData.map((element) {
        return FlyTypeModel.fromJson(element);
      }).toList();

      return flyType;
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

  static Future getAllFlySampleTypes() async {
    String url = "${apiUrl}FlySampleTypes/GetAllFlySampleTypes";

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

      List flySample = jsonData.map((element) {
        return FlySampleTypeModel.fromJson(element);
      }).toList();

      return flySample;
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

  static Future getAllFlyNotes() async {
    String url = "${apiUrl}FlyNotes/GetAllFlyNotes";

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

      List flyNotes = jsonData.map((element) {
        return FlyNoteModel.fromJson(element);
      }).toList();

      return flyNotes;
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

  static Future getInsectExploration(int id) async {
    String url = "${apiUrl}InsectExplorations/GetInsectExploration/$id";

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

      List insectExploration = jsonData.map((element) {
        return InsectExplorationsModel.fromJson(element);
      }).toList();

      return insectExploration;
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
