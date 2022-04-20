import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/db/auth_shared_preferences.dart';
import '../../../utils/constants.dart';

class DailyWorkService {
  static Future addLine({
    required String date,
    required String lat,
    required String long,
    required String speed,
  }) async {
    var url = "${apiUrl}VehiclesInfos/AddVehicleInfos";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${TokenPref.getTokenValue()}',
          },
          body: jsonEncode({
            "VehicleId": 2,
            "VehicleInfos": [
              {"Date": date, "Lat": lat, "Long": long, "Speed": speed}
            ]
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
