import 'dart:convert';
import 'dart:developer';

import 'package:prepare/model/category_model.dart';
import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProjectServices {
  static Future<List<dynamic>> getAllProjects() async {
    String url = "${apiUrl}Projects/GetAllProjects";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZHZpc29yIiwianRpIjoiNTlkODRhNzktN2ViOS00NWM2LTg0MDgtZWZlYjg5MDdmYWExIiwiZW1haWwiOiJBZHZpc29yQGdtYWlsLmNvbSIsInVpZCI6ImI3NGRkZDE0LTYzNDAtNDg0MC05NWMyLWRiMTI1NTQ4NDNlNSIsInJvbGVzIjoiQWR2aXNvciIsImV4cCI6MTY0MzYyMDczNSwiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.Vqr9f5YASswN3fIElIZ2GbyEhcn1LDOw0d9QGBRGhbs',
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
    }
    return [];
  }
}
