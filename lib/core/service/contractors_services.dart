import 'dart:convert';
import 'dart:developer';
//import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/model/contractors_list_model.dart';
import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;
class ContractrosServices{
   static Future getAllContractros() async {
    String url = "${apiUrl}Contractors/GetAllContractors";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZHZpc29yIiwianRpIjoiNmQyNGQ3OWYtYmRmNi00Y2JlLWI2MmUtY2FjZmJiYTA3OTRmIiwiZW1haWwiOiJBZHZpc29yQGdtYWlsLmNvbSIsInVpZCI6ImI3NGRkZDE0LTYzNDAtNDg0MC05NWMyLWRiMTI1NTQ4NDNlNSIsInJvbGVzIjoiQWR2aXNvciIsImV4cCI6MTY0NzMzMzMwNiwiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.AMw6Ffok-igb-HQA4eMOGKC18Hrw2TKkAEu9EKuu4JE',
      },
    );
    //   log("token is : ${TokenPref.getTokenValue()}");
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List contractors = jsonData.map((element) {
        return ContractorsListModel.fromJson(element);
      }).toList();

      return contractors;
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

    static Future addEvaluation({
    required int contractorId,
    required List rates,

  }) async {
    var url = "${apiUrl}ContractorsRates/AddContractorRates";

    try {
      var res = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZHZpc29yIiwianRpIjoiNmQyNGQ3OWYtYmRmNi00Y2JlLWI2MmUtY2FjZmJiYTA3OTRmIiwiZW1haWwiOiJBZHZpc29yQGdtYWlsLmNvbSIsInVpZCI6ImI3NGRkZDE0LTYzNDAtNDg0MC05NWMyLWRiMTI1NTQ4NDNlNSIsInJvbGVzIjoiQWR2aXNvciIsImV4cCI6MTY0NzMzMzMwNiwiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.AMw6Ffok-igb-HQA4eMOGKC18Hrw2TKkAEu9EKuu4JE',
          },
          body: jsonEncode({
            "ContractorId": contractorId,
            "Rates": rates,
  
          }));
log("res $res");
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