import 'dart:convert';
import 'dart:io';

import '../db/auth_shared_preferences.dart';

// ignore: implementation_imports
import 'package:async/src/delegate/stream.dart';
import 'package:path/path.dart';
import 'package:prepare/model/animal_model.dart';
import 'package:prepare/model/animal_nearst_point_model.dart';

import 'package:prepare/utils/constants.dart';
import 'package:http/http.dart' as http;

class AnimalServices {
  static Future sendAnimalFormData({
    required street,
    required districtId,
    required File imge,
    required File imge2,
    required lat,
    required long,
    required code,
  }) async {
    final Uri url = Uri.parse('${apiUrl}StrayDogs/AddStrayDog');

    // ignore: deprecated_member_use

    var headers = <String, String>{
      "Content-type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
    };

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(headers);
    if (imge.path != "") {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(imge.openRead()));
      // ignore: deprecated_member_use

      var length = await imge.length();

      var multipartFile1 = http.MultipartFile('Image1', stream, length,
          filename: basename(imge.path));

      request.files.add(multipartFile1);
    }
    if (imge2.path != "") {
      // ignore: deprecated_member_use
      var stream2 = http.ByteStream(DelegatingStream.typed(imge2.openRead()));

      var length2 = await imge2.length();

      var multipartFile2 = http.MultipartFile('Image2', stream2, length2,
          filename: basename(imge2.path));

      request.files.add(multipartFile2);
    }
    request.fields["Lat"] = "$lat";
    request.fields["Long"] = "$long";
    request.fields["Street"] = "$street";
    request.fields["DistrictId"] = "$districtId";
    request.fields["Code"] = "$code";

    var response = await request.send();

    if (response.statusCode == 400) {
      return 400;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      return 200;
    }
  }

  //=================================================================================
  static Future getAnimalCode(int cityId) async {
    String url = "${apiUrl}StrayDogs/GetStrayDogCode/$cityId";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
      },
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      var data = res.body;

      return data;
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      return "عير مصرح للمستخدم";
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return "يوجد مشكلة ";
    } else if (res.statusCode == 400) {
      var errorMsg = jsonDecode(res.body);

      return errorMsg['errors'][0][0];
    }
  }
//================================================================

  static Future getAnimal() async {
    String url = "${apiUrl}StrayDogs/GetAllStrayDogs";

    http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-type": "application/json",
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
        'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
      },
    );

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      List animal = jsonData.map((element) {
        return AnimalModel.fromJson(element);
      }).toList();

      return animal;
    } else if (res.statusCode == 401) {
      return 401;
    } else if (res.statusCode == 500 ||
        res.statusCode == 501 ||
        res.statusCode == 504 ||
        res.statusCode == 502) {
      return 500;
    } else if (res.statusCode == 400) {
      var errorData = jsonDecode(res.body);

      return errorData['errors'][0][0];
    }
  }

//==========================================================

  static Future sendVisitAnimalFormData({
    required strayDogId,
    required File imge,
    required File imge2,
  }) async {
    final Uri url = Uri.parse('${apiUrl}StrayDogVisits/AddStrayDogVisit');

    // ignore: deprecated_member_use

    var headers = <String, String>{
      "Content-type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getTokenValue()}',
    };

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(headers);
    if (imge.path != "") {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(imge.openRead()));
      // ignore: deprecated_member_use

      var length = await imge.length();

      var multipartFile1 = http.MultipartFile('Image1', stream, length,
          filename: basename(imge.path));

      request.files.add(multipartFile1);
    }
    if (imge2.path != "") {
      // ignore: deprecated_member_use
      var stream2 = http.ByteStream(DelegatingStream.typed(imge2.openRead()));

      var length2 = await imge2.length();

      var multipartFile2 = http.MultipartFile('Image2', stream2, length2,
          filename: basename(imge2.path));

      request.files.add(multipartFile2);
    }

    request.fields["strayDogId"] = "$strayDogId";

    var response = await request.send();

    if (response.statusCode == 400) {
      return 400;
    } else if (response.statusCode == 401) {
      return 401;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      return 200;
    }
  }

//================================================================

//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  static Future getNearstAnimalVisit(double lat, double long) async {
    String url = "${apiUrl}StrayDogs/GetClosestStrayDogs/$lat/$long";
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
      var jsonData = jsonDecode(res.body);

      List closeAnimalVisit = jsonData.map((element) {
        return NearstAnimalPointModel.fromJson(element);
      }).toList();

      return closeAnimalVisit;
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