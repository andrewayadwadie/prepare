import 'dart:convert';
import 'dart:developer';

import 'package:prepare/model/category_model.dart';
import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProjectServices {
  static Future  getAllProjects() async {
    String url = "${apiUrl}Projects/GetAllProjects";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZHZpc29yIiwianRpIjoiMWY0NzMzODQtMGI1MC00NWM4LWFlODktMWNkOTU3YTgyMTlmIiwiZW1haWwiOiJBZHZpc29yQGdtYWlsLmNvbSIsInVpZCI6ImI3NGRkZDE0LTYzNDAtNDg0MC05NWMyLWRiMTI1NTQ4NDNlNSIsInJvbGVzIjoiQWR2aXNvciIsImV4cCI6MTY0MzcxMDgxMSwiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.6D69kXl64UPZLaQkvN5qCgxNvXRoiPCyQeJSXondyGM',
      },
    );

    log("request res ${res.body}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      log("message$jsonData");
      List projects = jsonData.map((element) {
        return ProjectModel.fromJson(element);
      }).toList();

      return projects;
    }else if(res.statusCode == 401){
      return 401;
    }else if(res.statusCode == 500 || res.statusCode == 501 || res.statusCode == 504 || res.statusCode == 502){
      return 500 ;
    }
    return 400;
  }
}
