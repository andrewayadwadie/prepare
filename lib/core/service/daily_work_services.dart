import 'dart:convert';
import 'dart:developer';

import '../db/auth_shared_preferences.dart';
import '../../model/daily_task_model.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class DailyWorkServices {
  static Future getAllPoint() async {
    String url = "${apiUrl}VehiclesInfos/GetTodayVehicleInfos/2";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
      },
    );
    log("status code is : ${res.statusCode}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List vehicles = jsonData.map((element) {
        return DailyTaskModel.fromJson(element);
      }).toList();

      return vehicles;
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
