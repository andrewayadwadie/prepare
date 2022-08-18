import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../core/db/auth_shared_preferences.dart';
import '../../../utils/constants.dart';

class CompleteTaskService {
  static Future completeTask({
    required int districtId,
    required int routeId,
  }) async {
    var url = "${apiUrl}DistrictLocations/CompleteTask/$districtId/$routeId";

    try {
      var res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        dynamic jsonData = jsonDecode(res.body);
        log(" response test is : $jsonData and  run type is : ${jsonData.runtimeType}");
        return jsonData;
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
