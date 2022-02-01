import 'dart:convert';

import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/cars_model.dart';
import 'package:prepare/model/devices_model.dart';
import 'package:prepare/model/pestSide_model.dart';
import 'package:prepare/model/tools_model.dart';
import 'package:prepare/model/user_prepration_model.dart';
import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class PreprationServices {
  static Future getUserPrepration(int id) async {
    String url = "${apiUrl}Preparations/GetUserPreparation/$id";

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

      // List data = jsonData.map((element) {
      //   return UserPreprationModel.fromJson(element);
      // }).toList();

      dynamic data = UserPreprationModel.fromJson(jsonData);

      return data;
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

  static Future getAllCars() async {
    String url = "${apiUrl}Vehicles/GetAllVehicles";

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

      List cars = jsonData.map((element) {
        return CarsModel.fromJson(element);
      }).toList();

      return cars;
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

  static Future getAllPesides() async {
    String url = "${apiUrl}Exterminators/GetAllExterminators";

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

      List cars = jsonData.map((element) {
        return PestSideModel.fromJson(element);
      }).toList();

      return cars;
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

  static Future getAllTools() async {
    String url = "${apiUrl}Tools/GetAllTools";

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

      List cars = jsonData.map((element) {
        return ToolsModel.fromJson(element);
      }).toList();

      return cars;
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

  static Future getAllDevices() async {
    String url = "${apiUrl}Devices/GetAllDevices";

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

      List cars = jsonData.map((element) {
        return DevicesModel.fromJson(element);
      }).toList();

      return cars;
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

  static Future addPrepration({
    required int projectId,
    required int numberOfEmployees,
    required int numberOfTools,
    required int numberOfVehicles,
    required int numberOfDevices,
    required int numberOfExterminators,
  }) async {
    var url = "${apiUrl}Preparations/AddPreparation";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
          },
          body: jsonEncode({
            "ProjectId": projectId,
            "NumberOfEmployees": numberOfEmployees,
            "NumberOfTools": numberOfTools,
            "NumberOfVehicles": numberOfVehicles,
            "NumberOfDevices": numberOfDevices,
            "NumberOfExterminators": numberOfExterminators
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
