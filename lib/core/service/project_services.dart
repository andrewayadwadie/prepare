import 'dart:convert';

import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/project_model.dart';
import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProjectServices {
  static Future getAllProjects() async {
    String url = "${apiUrl}Preparations/GetProjectsWithUserPreparationStatus";

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

      List projects = jsonData.map((element) {
        return ProjectModel.fromJson(element);
      }).toList();

      return projects;
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
