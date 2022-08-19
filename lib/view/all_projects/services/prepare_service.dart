import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants.dart';
import '../../auth/login_screen.dart';

import '../../../core/db/auth_shared_preferences.dart';

class PrepareServices {
  static Future addPrepartion({
    required int cityId,
    required int projectId,
    required String numberOfTeams,
    required String numberOfSectorSupervisors,
    required String numberOfControlSpecialist,
    required String numberOfEmployees,
    required List projectTrackVehicleTypesPreparations,
  }) async {
    var url = "${apiUrl}Preparations/AddPreparation";
    try {
      log("""
              {
                    "ProjectId": $projectId,
                    "ProjectCityPreparation": {
                      "NumberOfTeams": $numberOfTeams,
                      "NumberOfSectorSupervisors": $numberOfSectorSupervisors,
                      "NumberOfControlSpecialist": $numberOfControlSpecialist,
                      "NumberOfEmployees": $numberOfEmployees,
                      "CityId": $cityId,
                      "ProjectTrackVehicleTypesPreparations":
                          $projectTrackVehicleTypesPreparations
                    }
                  }
              """);
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
          },
          body: jsonEncode({
            "ProjectId": projectId,
            "ProjectCityPreparation": {
              "NumberOfTeams": numberOfTeams,
              "NumberOfSectorSupervisors": numberOfSectorSupervisors,
              "NumberOfControlSpecialist": numberOfControlSpecialist,
              "NumberOfEmployees": numberOfEmployees,
              "CityId": cityId,
              "ProjectTrackVehicleTypesPreparations":
                  projectTrackVehicleTypesPreparations
            }
          }));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return 200;
      } else if (res.statusCode == 400) {
        var registerDataJson = jsonDecode(res.body);
        return registerDataJson['errors'][0][0];
      } else if (res.statusCode == 401) {
        Get.offAll(() => const LoginScreen());
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
