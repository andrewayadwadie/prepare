import 'dart:convert';

import '../../view/all_projects/model/prepare_model.dart';
import '../db/auth_shared_preferences.dart';
 
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class ProjectServices {
  static Future getAllProjects() async {
    String url = "${apiUrl}Preparations/GetAllProjectsWithStatusPreparation";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
      },
    );
    //   log("token is : ${SharedPref.getTokenValue()}");
    if (res.statusCode == 200) {
       List<dynamic> jsonData = jsonDecode(res.body);

      List<ProjectModel> projects = jsonData.map((element) {
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
